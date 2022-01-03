module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnets         = data.aws_subnet_ids.private-subnets.ids

  enable_irsa = true

  tags = {
    Environment = local.env_name
    owner       = local.owner
    project     = local.project
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }
  map_roles = [
    {
      rolearn  = data.aws_iam_instance_profile.consul_policy.arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:masters"]
    }
  ]

  vpc_id = data.aws_vpc.ops-school-prod-vpc.id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t3.medium"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
    },
  ]

}