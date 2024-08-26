# Terraform Configuration file ##

terraform {
  required_version = "~>1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
  backend "s3" {
    bucket         = "devopstrainee-terraform-bucket"
    key            = "terraform/dev/terraform.tfstate"
    region         = "eu-west-2"
  }
}

provider "aws" {
  region = var.aws-region
}

