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

#############  Route53  #############
variable "aws_registered_domains" {
  description = "my aws registered domains "
  type        = string
  default     = "eran.website"
}

variable "ubuntu_account_number" {
  default = "099720109477"
}

#############  EKS  #############
variable "kubernetes_version" {
  default = 1.21
  description = "kubernetes version"
}
locals {

}

#############
# LOCALS
#############

locals {
  cluster_name                  = "opsschool-eks-kandula-prod"
  k8s_service_account_namespace = "default"
  k8s_service_account_name      = "opsschool-sa"

  env_name                      = "ops-school-prod"
  owner                         = "Eran Moshayov"
  project                       = "kandula"

  common_tags = {
    Owner       = local.owner
    Environment = local.env_name
    Project     = local.project
  }
}