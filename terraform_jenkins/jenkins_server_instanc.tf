#################
#   INSTANCES   #
#################

#######   Jenkins-Server INSTANCES   ############

resource "aws_instance" "jenkins-server" {
  ami                         = var.jenkins_server_ami
  instance_type               = var.jenkins_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1a.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  user_data                   = local.jenkins-server-instance-userdata


  tags = {
    Name = "Jenkins-Server"
    Owner = local.owner
    Environment = local.env_name
  }

}
