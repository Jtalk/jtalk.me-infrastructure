terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.0.4"
}

provider "aws" {
  profile = "jtalk.me-root"
  region  = "eu-west-2"
}
