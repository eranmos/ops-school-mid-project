# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM centos:7
MAINTAINER Eran Moshayov | DevOps Team | <eran.ops.school@gmail.com>

# Make sure the package repository is up to date.
RUN yum update -y


# Install EPEL repo
RUN yum install -y \
   epel-release

# Install need packages
RUN yum install -y \
   java-1.8.0-openjdk \
   git \
   cifs-utils \
   qemu-kvm \
   python \
   python-setuptools \
   python-devel \
   pcre.x86_64 \
   pcre-devel.x86_64 \
   pcre-static.x86_64 \
   zlib-devel.x86_64 \
   zlib-static.x86_64 \
   zlib.x86_64 \
   openssl-devel.x86_64 \
   unzip \
   python-pip \
   which \
   wget \
   libtool-ltdl \
   pigz \
   sshpass

RUN yum group install -y "Development Tools"

RUN cd /opt && \
    wget -q https://services.gradle.org/distributions/gradle-3.3-bin.zip && \
    unzip gradle-3.3-bin.zip && \
    chmod +x /opt/gradle-3.3/bin/gradle && \
    ln -s /opt/gradle-3.3/bin/gradle /usr/bin/gradle

# Install a basic SSH server
RUN yum install -y openssh-server && \
    ssh-keygen -A && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd

# Add user jenkins to the image
RUN adduser jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    groupadd -g 1012 docker && usermod -a -G docker jenkins

# Clean
RUN yum clean all && rm -rf /var/cache/yum

# Standard SSH port
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]