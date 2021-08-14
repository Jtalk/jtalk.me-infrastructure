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