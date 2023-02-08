terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.0.0-rc1"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "random" {}

provider "http" {}

provider "cloudflare" {}
