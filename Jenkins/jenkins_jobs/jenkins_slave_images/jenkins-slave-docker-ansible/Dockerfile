# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:18.04
MAINTAINER Eran Moshayov | DevOps Team | <eran.ops.school@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
# Install maven
    apt-get install -qy maven && \
# Cleanup old packages
    apt-get -qy autoremove && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2 && \
# Install Ansible
    apt-get install python-pip -y && \
    pip install botocore && \
    pip install boto && \
    pip install boto3 && \
    apt-get install software-properties-common -y && \
    add-apt-repository --yes --update ppa:ansible/ansible && \
    apt-get install ansible -y && \
    apt-get install ansible-lint -y && \
    ansible-galaxy collection install amazon.aws && \
    mkdir /etc/ansible/inventory && \
    mkdir /etc/ansible/inventory/group_vars

# Copy Ansible config
COPY .ansible_files/ansible.cfg /etc/ansible/ansible.cfg
# Copy Ansible Inventory
COPY .ansible_files/aws_ec2.yaml /etc/ansible/inventory/aws_ec2.yaml
# Copy Ansible User
COPY .ansible_files/all.yaml /etc/ansible/inventory/group_vars/

# Copy authorized keys
COPY .ansible_keys/id_rsa /home/jenkins/.ssh/id_rsa

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/ && \
    chown jenkins:jenkins /home/jenkins/.ssh/id_rsa \
    chmod  400 /home/jenkins/.ssh/id_rsa

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]