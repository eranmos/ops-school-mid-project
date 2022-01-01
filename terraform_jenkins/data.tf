##########
# DATA
##########

########## Getting VPC  ##########
data "aws_vpc" "ops-school-prod-vpc" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc"]
  }
}

########## Getting Subnets  ##########
data "aws_subnet_ids" "private-subnets" {
  vpc_id =data.aws_vpc.ops-school-prod-vpc.id
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-private-*"]
  }
}

data "aws_subnet" "private-us-east-1a" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-private-us-east-1a"]
  }
}

data "aws_subnet" "public-us-east-1a" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-public-us-east-1a"]
  }
}

data "aws_subnet" "private-us-east-1b" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-private-us-east-1b"]
  }
}

data "aws_subnet" "public-us-east-1b" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-public-us-east-1b"]
  }
}

data "aws_route53_zone" "my_aws_registered_domain" {
  name = var.aws_registered_domains
}

data "aws_acm_certificate" "issued" {
  domain   = "*.eran.website"
  statuses = ["ISSUED"]
}

########## Getting AMI's from publifc images  ##########
data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_iam_instance_profile" "consul_policy" {
  name   = "consul-join"
}
