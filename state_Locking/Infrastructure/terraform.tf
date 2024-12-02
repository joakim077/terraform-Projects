terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.78.0"
    }
  }
  backend "s3" {
    bucket = "backend-and-statelock-384e-3u32-7"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-table"
  }
}
provider "aws" {
  region = var.aws_region
}