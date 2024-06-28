terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.55.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.93.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {}