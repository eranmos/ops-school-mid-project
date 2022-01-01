#############
# Providers #
#############
provider "aws" {
  region  = var.aws_region
  profile = var.aws_cli_profile
}

terraform {
  required_version = "1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket  = "eran-terraform-state-bucket"
    key     = "ops-school-prod/bastion/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "ops-school"
    #    dynamodb_table = "terraform-state-lock"
  }
}