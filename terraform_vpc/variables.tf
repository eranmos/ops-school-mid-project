#############
# Variables #
#############

#############  VPC Related  #############
variable "aws_region" {
  default = "us-east-1"
}

variable "availablity_zone_a" {
  default = "us-east-1a"
}

variable "availablity_zone_b" {
  default = "us-east-1b"
}

variable "private_dns_name" {
  default = "opsschool.internal"
}

#############  Network  #############
variable "network_address_space" {
  default = "10.0.0.0/21"
}
variable "public_subnet1_address_space" {
  default = "10.0.0.0/24"
}
variable "private_subnet1_address_space" {
  default = "10.0.2.0/23"
}
variable "public_subnet2_address_space" {
  default = "10.0.1.0/24"
}
variable "private_subnet2_address_space" {
  default = "10.0.4.0/23"
}
#####################################################


#############  aws cli  #############
variable "aws_cli_profile" {
  default = "ops-school"
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