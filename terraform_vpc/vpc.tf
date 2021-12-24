#############
#    VPC    #
#############

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"
  name = "${local.env_name}-vpc"
  azs             = [var.availablity_zone_a, var.availablity_zone_b]
  cidr = var.network_address_space
  private_subnets = [var.private_subnet1_address_space, var.private_subnet2_address_space]
  public_subnets  = [var.public_subnet1_address_space, var.public_subnet2_address_space]

  enable_dns_hostnames = true
  enable_nat_gateway = false
  single_nat_gateway = true
  enable_vpn_gateway = false
  enable_dhcp_options = true
  dhcp_options_domain_name = var.private_dns_name

  tags = local.common_tags
}
