#############
# User Data #
#############

locals {
  jenkins-server-instance-userdata = <<USERDATA
#!/bin/bash
sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"
USERDATA
}