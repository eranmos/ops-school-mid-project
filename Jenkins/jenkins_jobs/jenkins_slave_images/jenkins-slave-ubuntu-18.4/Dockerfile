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
# Install Docker
    apt install docker.io -y && \
    usermod -aG docker jenkins && \
# Install packages needed to use the Kubernetes apt repository:
    apt-get install -y apt-transport-https ca-certificates curl && \
# Download the Google Cloud public signing key:
    curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
# Install packages needed to use the Kubernetes apt repository:
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
# Update apt package index with the new repository and install kubectl:
    apt-get update && \
    apt-get install -y kubectl

#ADD settings.xml /home/jenkins/.m2/
# Copy authorized keys
COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]