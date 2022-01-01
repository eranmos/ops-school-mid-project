#################
#   INSTANCES   #
#################

#######     Bastion INSTANCES   ############
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.public-us-east-1a.id
  associate_public_ip_address = true
  iam_instance_profile        = data.aws_iam_instance_profile.consul_policy.name
  vpc_security_group_ids      = [aws_security_group.bastion-server.id]
  user_data                   = local.bastion-server-instance-userdata

  tags = {
    Name        = "bastion-server"
    Owner       = local.owner
    Environment = local.env_name
  }
}