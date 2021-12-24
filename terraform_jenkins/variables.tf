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

#############  Jenkins Server  #############
variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
  default     = "eran-aws-linux"
}

locals {
  jenkins_default_name = "jenkins"
  jenkins_home = "/home/ubuntu/jenkins_home"
  jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
  docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
  java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"
}

variable "jenkins_instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
  default     = "t3.micro"
}

variable "jenkins_ami" {
  description = "The ami of the jenkins server"
  type        = string
  default     = "ami-01e5ad126c78fa17c"
}
#############  Route53  #############
variable "aws_registered_domains" {
  description = "my aws registered domains "
  type        = string
  default     = "eran.website"
}

variable "jenkins_dns" {
  description = "my aws registered domains "
  type        = string
  default     = "jenkins.eran.website"
}


#############
# LOCALS
#############

locals {
  env_name = "ops-school-prod"
  owner = "Eran Moshayov"

  common_tags = {
    Owner = local.owner
    Environment = local.env_name
  }
}