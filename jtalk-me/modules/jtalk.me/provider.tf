terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
  required_version = ">= 1.0.4"
}
