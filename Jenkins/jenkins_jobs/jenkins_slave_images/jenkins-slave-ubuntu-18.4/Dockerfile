# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:18.04
MAINTAINER Eran Moshayov | DevOps Team | <eran.ops.school@gmail.com>

# Make sure the package repository is up to date.
RUN apt update -y

# Install need packages
RUN


# Add user jenkins to the image
RUN adduser jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    groupadd -g 1012 docker && usermod -a -G docker jenkins

# Standard SSH port
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]