locals {
  bastion-server-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install python3-pip
sudo apt install awscli -y
aws s3 cp s3://${var.default_s3_bucket}/ansible_keys/id_rsa /home/ubuntu/
sudo mv /home/ubuntu/id_rsa /home/ubuntu/.ssh/id_rsa
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
sudo chmod  400 /home/ubuntu/.ssh/id_rsa
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

USERDATA
}