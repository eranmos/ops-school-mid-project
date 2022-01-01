#############
# Providers #
#############
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_cli_profile" {
  default = "ops-school"
}

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
    key     = "ops-school-prod/vpc/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "ops-school"
    #    dynamodb_table = "terraform-state-lock"
  }
}

