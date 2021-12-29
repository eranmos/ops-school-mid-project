#################
#   INSTANCES   #
#################

#######   Consul-Server INSTANCES   ############

resource "aws_instance" "consul-server" {
  count                       = var.consul_instances_count
  ami                         = var.ami
  instance_type               = var.consul_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1a.id
  iam_instance_profile        = aws_iam_instance_profile.consul-join.name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.consul-server.id]
#  user_data                   = local.consul-server-instance-userdata


  tags = {
    Name = "Consul-Server${count.index+1}"
    consul = "consul-server"
    Owner = local.owner
    Environment = local.env_name
  }

}