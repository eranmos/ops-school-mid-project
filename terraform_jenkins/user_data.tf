#############
# User Data #
#############

locals {
  jenkins-server-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install python3-pip
sudo apt install awscli -y
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe3eJDO2vAennWX4IDtRAU3XPHr0LGXQaKyKhbgD98woWkHp7Fy0mnxiTeN4aVZ5EuBWh5Ganyvud0giRLucVDjH/mvkhrhuCGmTnOLVswsF15O2TYlBlOO5jtSvfSqmjy1cvytQ2SQZAP+WbmasOmAs5+r45PfWFcSSD/ZOnEE0KcgB/vbdCbxQQq+FKfZnI4t5bFdMm6ZJ4SlI+MioME6jPFKb6n4qq2TJrvTbgrJDyEA+EEMX2v/3BtfS+fXP3LIvJIED1NNEMC3YNQQydWxQzz1XG48A/G7pP/1VSliP65YYHFbq9SXPezmCy1aHS9JbX+jy7JN+S1ksyVEZZ6n/2dDbedg7YuoSWn/mc9d6nmpcbAYQ+TaruiABiHdDzBx+XLk7uwSTnUli1TTaHgStohGV3vw8iqNvp7khnvnUc1dh3yU+c73oNpCpToufwAu2yLHMg1s5gzCZs1PqWqjOgWySdNEAG9NtHZvTHHh3QPcm82S2ZRvxBjr3v5dlM5qbP3+bNM6kc9ylCjygcJRb2dVkHlBBL4Avv0Dq+36iy8Tk4uKrKmdJtXvBertuTessknyb2lRzjNjyRRwSwaTHEdIUNOiZTt3ZZyRAm6h0vxFKixfERDpnCznH4DtLTwdA5HtWe+5uK/2fXWCu6c5pbLz4Zv5os1BuuJep1vRQ== ubuntu@ip-172-31-22-246" >> /home/ubuntu/.ssh/authorized_keys
chmod  600 /home/ubuntu/.ssh/authorized_keys
sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"
sudo sed -i $'/ExecStart=/c\\ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock\n' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker restart

USERDATA
}

locals {
  jenkins-slave-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install awscli -y

# Permissions
aws s3 cp s3://${var.default_s3_bucket}/ansible_keys/id_rsa /home/ubuntu/
sudo mv /home/ubuntu/id_rsa /home/ubuntu/.ssh/id_rsa
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
sudo chmod  400 /home/ubuntu/.ssh/id_rsa
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe3eJDO2vAennWX4IDtRAU3XPHr0LGXQaKyKhbgD98woWkHp7Fy0mnxiTeN4aVZ5EuBWh5Ganyvud0giRLucVDjH/mvkhrhuCGmTnOLVswsF15O2TYlBlOO5jtSvfSqmjy1cvytQ2SQZAP+WbmasOmAs5+r45PfWFcSSD/ZOnEE0KcgB/vbdCbxQQq+FKfZnI4t5bFdMm6ZJ4SlI+MioME6jPFKb6n4qq2TJrvTbgrJDyEA+EEMX2v/3BtfS+fXP3LIvJIED1NNEMC3YNQQydWxQzz1XG48A/G7pP/1VSliP65YYHFbq9SXPezmCy1aHS9JbX+jy7JN+S1ksyVEZZ6n/2dDbedg7YuoSWn/mc9d6nmpcbAYQ+TaruiABiHdDzBx+XLk7uwSTnUli1TTaHgStohGV3vw8iqNvp7khnvnUc1dh3yU+c73oNpCpToufwAu2yLHMg1s5gzCZs1PqWqjOgWySdNEAG9NtHZvTHHh3QPcm82S2ZRvxBjr3v5dlM5qbP3+bNM6kc9ylCjygcJRb2dVkHlBBL4Avv0Dq+36iy8Tk4uKrKmdJtXvBertuTessknyb2lRzjNjyRRwSwaTHEdIUNOiZTt3ZZyRAm6h0vxFKixfERDpnCznH4DtLTwdA5HtWe+5uK/2fXWCu6c5pbLz4Zv5os1BuuJep1vRQ== ubuntu@ip-172-31-22-246" >> /home/ubuntu/.ssh/authorized_keys
chmod  600 /home/ubuntu/.ssh/authorized_keys

# Jenkins slave related
sudo apt install git -y
sudo apt-get install openjdk-8-jdk -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins
sudo sed -i $'/ExecStart=/c\\ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock\n' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker restart

# Ansible Server related
sudo apt install python-pip -y
sudo pip install botocore
sudo pip install boto
sudo pip install boto3
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install ansible-lint -y
sudo ansible-galaxy collection install amazon.aws
sudo mkdir /etc/ansible/inventory
aws s3 cp s3://${var.default_s3_bucket}/ansible_files/ansible.cfg /home/ubuntu/
aws s3 cp s3://${var.default_s3_bucket}/ansible_files/aws_ec2.yaml /home/ubuntu/
aws s3 cp s3://${var.default_s3_bucket}/ansible_files/group_vars/all.yaml /home/ubuntu/
sudo mv /home/ubuntu/ansible.cfg /etc/ansible/ansible.cfg
sudo mv /home/ubuntu/aws_ec2.yaml /etc/ansible/inventory/aws_ec2.yaml
sudo mkdir /etc/ansible/inventory/group_vars/
sudo mv /home/ubuntu/all.yaml /etc/ansible/inventory/group_vars/
sudo chown -R ubuntu:ubuntu /home/ubuntu/.ansible

USERDATA
}