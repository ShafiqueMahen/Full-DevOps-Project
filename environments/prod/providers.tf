terraform {
  required_version = ">= 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
    backend "s3" {
        bucket = "terraform-tfstate-storage-bucket-shaf"
        key = "prod/terraform.tfstate"
        region = "eu-west-2"
    }
}
provider "aws" {
  region  = var.aws_region
}
