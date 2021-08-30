terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  backend "s3" {
    bucket = "jtalk.me-terraform-state"
    key    = "state"
    region = "eu-west-2"
  }

  required_version = ">= 1.0.4"
}

provider "aws" {
  region = "eu-west-2"
}

provider "aws" {
  region = "eu-north-1"
  alias  = "aws_backups"
}

variable "do_token" {}
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

provider "kubernetes" {
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

variable "cloudflare_account_id" {}
variable "cloudflare_api_token" {}
provider "cloudflare" {
  account_id = var.cloudflare_account_id
  api_token  = var.cloudflare_api_token
}

variable "atlas_key" {}
variable "atlas_key_secret" {}
provider "mongodbatlas" {
  public_key  = var.atlas_key
  private_key = var.atlas_key_secret
}
