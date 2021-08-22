terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket  = "jtalk.me-terraform-state"
    key     = "state"
    profile = "jtalk.me-terraform"
    region  = "eu-west-2"
  }

  required_version = ">= 1.0.4"
}

variable "do_token" {}

provider "aws" {
  profile = "jtalk.me-terraform"
  region  = "eu-west-2"
}

provider "digitalocean" {
  token = var.do_token
}

provider "helm" {
  kubernetes {
    host = digitalocean_kubernetes_cluster.main_cluster.endpoint
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.main_cluster.kube_config[0].cluster_ca_certificate
    )
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "doctl"
      args = ["kubernetes", "cluster", "kubeconfig", "exec-credential",
      "--version=v1beta1", digitalocean_kubernetes_cluster.main_cluster.id]
    }
  }
}

variable "cloudflare_account_id" {}
variable "cloudflare_api_token" {}

provider "cloudflare" {
  account_id = var.cloudflare_account_id
  api_token  = var.cloudflare_api_token
}

