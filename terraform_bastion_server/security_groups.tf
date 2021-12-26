####################
# Security Groups   #
####################

#######   Bastion Server Security Group   ############

resource "aws_security_group" "bastion-server" {
  vpc_id = data.aws_vpc.ops-school-prod-vpc.id
  name = local.bastion_default_name
  description = "Allow bastion inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = local.bastion_default_name
    Owner = local.owner
    Environment = local.env_name


  }
}