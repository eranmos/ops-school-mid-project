##########
# OUTPUT
##########

#Network VPC Info
output "my_aws_available_azs" {
  value = module.vpc.azs
}

output "aws_vpc_name" {
  value = module.vpc.name
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_public_subnets_id" {
  value = "${module.vpc.public_subnets}"
}

output "vpc_private_subnets_id" {
  value = "${module.vpc.private_subnets}"
}
