########## Getting Subnets  ##########
data "aws_subnet" "private-subnets" {
  filter {
    name   = "tag:Name"
    values = "ops-school-prod-vpc-private-us-east-1a&ops-school-prod-vpc-private-us-east-1b"
  }
}

data "aws_subnet" "private-us-east-1a" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-private-us-east-1a"]
  }
}

data "aws_subnet" "private-us-east-1b" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-prod-vpc-private-us-east-1b"]
  }
}