#############
# Variables #
#############

#############  VPC Related  #############
variable "aws_region" {
  default = "us-east-1"
}

#############  aws cli  #############
variable "aws_cli_profile" {
  default = "ops-school"
}

variable "ubuntu_account_number" {
  default = "099720109477"
}

variable "instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
  default     = "eran-aws-linux"
}

variable "default_s3_bucket" {
  description = "AWS EC2 Instance type"
  default     = "eran-terraform-state-bucket"
}

locals {
  bastion_default_name = "Bastion-Server"
  env_name             = "ops-school-prod"
  owner                = "Eran Moshayov"
  project              = "kandula"


  common_tags = {
    Owner       = local.owner
    Environment = local.env_name
    Project     = local.project
  }
}