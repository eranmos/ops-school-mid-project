#################
#   INSTANCES   #
#################

#######   Jenkins-Slave INSTANCES   ############

resource "aws_instance" "jenkins-slave" {
  count                       = var.jenkins_slave_instances_count
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.jenkins_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1b.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  user_data                   = local.jenkins-slave-instance-userdata


  tags = {
    Name = "Jenkins-Slave"
    Owner = local.owner
    Environment = local.env_name
  }

}
