#############
# User Data #
#############

locals {
  jenkins-server-instance-userdata = <<USERDATA
#!/bin/bash
sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"
USERDATA
}

locals {
  jenkins-slave-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt-get update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
mkdir -p ${local.jenkins_home}
sudo chown -R 1000:1000 ${local.jenkins_home}
}