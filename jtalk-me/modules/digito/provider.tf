terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.2"
    }
  }
  required_version = ">= 1.0.4"
}
