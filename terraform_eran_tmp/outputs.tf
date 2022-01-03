#Network VPC Info

output "eks_cluter" {
  value = data.aws_vpc.ops-school-prod-vpc
}
