terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

    backend "s3" {
        bucket         = "terraform-shivani-s3-backend-bucket-2"
        key            = "terraform.tfstate"
        region         = "us-east-1"
        dynamodb_table = "terraform-shivani-s3-backend-table"
    }
}
provider "aws" {
  region = "us-east-1"
}



