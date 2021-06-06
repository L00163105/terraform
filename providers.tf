terraform {
  required_providers {
    aws = {
      source  = var.provider_source
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.5"
}

provider "aws" {
  profile = "default"
  region  = var.region
}