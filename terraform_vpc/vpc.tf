#############
#    VPC    #
#############
locals {
  cluster_name = "opsschool-eks-kandula-prod"
}

module "vpc" {
  source = "git@github.com:eranmos/ops-school-terraform-aws-vpc.git"

  name            = "${local.env_name}-vpc"
  azs             = [var.availablity_zone_a, var.availablity_zone_b]
  cidr            = var.network_address_space
  private_subnets = [var.private_subnet1_address_space, var.private_subnet2_address_space]
  public_subnets  = [var.public_subnet1_address_space, var.public_subnet2_address_space]
  enable_dns_hostnames     = true
  enable_nat_gateway       = false
  enable_dhcp_options      = true
  dhcp_options_domain_name = var.private_dns_name

  tags = {
    Owner            = local.owner
    Environment      = local.env_name
    Project          = local.project
    eks_cluster_name = local.cluster_name
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
