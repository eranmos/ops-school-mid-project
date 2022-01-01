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

#############  Consul Server  #######
variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
  default     = "eran-aws-linux"
}

variable "consul_instances_count" {
  description = "numbers of consul servers"
  default     = "3"
}

variable "consul_instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "ami (ubuntu 18) to use"
  default = "ami-00ddb0e5626798373"
}

#############  Route53  #############
variable "aws_registered_domains" {
  description = "my aws registered domains "
  type        = string
  default     = "eran.website"
}

variable "consul_dns" {
  description = "my aws registered domains "
  type        = string
  default     = "consul.eran.website"
}

#############
# LOCALS
#############

locals {
  env_name = "ops-school-prod"
  owner    = "Eran Moshayov"
  project  = "kandula"

  common_tags = {
    Owner       = local.owner
    Environment = local.env_name
    Project     = local.project
  }
}