#data "template_file" "k8s_master_names" {
#  count    = "${var.master_count}"
#  template = "${lookup(aws_instance.k8s_master.*.tags[count.index], "Name")}"
#}

########## Getting VPC  ##########
data "aws_vpc" "ops-school-prod-vpc" {
  filter {
    name   = "tag:eks_cluster_name"
    values = ["opsschool-eks-*"]
  }
}

