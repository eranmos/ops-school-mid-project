<h1 align="center">Kandula</h1>
<h6 align="center">This Repo will aggregate my ops-school project</h6>

<p align="center"><img width="250px" src="./kandula.jpg"></p>

## Table of Contents

- [Infrastructure Architecture Diagram](#Infrastructure-Architecture-Diagram)
- [Application Diagram](#Application-Diagram)
- [IP Address Allocation](/network_address_design/network_adresses_design.md)
- [Deployment Process](#Deployment-Process)
- [Prerequisites](#prerequisites)
- [Deploying Instructions](#Deploying-Instructions)
- [Application Connections](#Application-Connections)
- [Project Terraform Deployments](#Project-Terraform-Deployments)
- [Links for dockerhub related images](#Links-for-dockerhub-related-images)
- [Links for GitHub related repository](#Links-for-GitHub-related-repository)

## Infrastructure Architecture Diagram
![architecture_diagram](./ops_school_project_architecture_diagram.png)

## Application Diagram
![app_diagram](./ops_school-project_app_diagram.png)

## Deployment Process
Infrastructure deployment will be performed via Terraform locally (on my pc).
Terraform deployment is divided into five parts when the first execution must be VPC and the sequence of rest is not important
 + [Terraform-VPC](terraform_vpc) - Creating VPC
 + [Terraform-Jenkins](terraform_jenkins) - Creating Jenkins Master & Jenkins Slave
 + [Terraform-Consul](/terraform_consul) - Creating Consul cluster
 + [Terraform-EKS](/terraform_eks) - Creating Kubernetes cluster with one worker group

After deploying the infrastructure via terraform we will need to provision our servers via Ansible playbooks.
All Ansible playbooks will be run via jenkins job ( Ansible installed on the Jenkins-slave).
Jenkins UI : https://jenkins.eran.website/










## Prerequisites

## Deploying Instructions

## Application Connections

### Jenkins Master :
| Protocol | Port        | ingress/egress | Description                                                    |
| -------  | ----------- |--------------- | -------------------------------------------------------------- |
| HTTPS    | 443         | ingress        | Allow Jenkins UI                                               |
| HTTP     | 8080        | ingress        | Allow Jenkins UI                                               |
| tcp      | 4243        | ingress        | Allow Docker Remote API                                        |
| tcp      | 32768-60999 | ingress        | Allow Docker Hostport Range                                    |
| tcp      | 22          | ingress        | Allow ssh                                                      |
| all      | all         | egress         | Allow all outgoing traffic                                     |

### Jenkins Slave :
| Protocol | Port        | ingress/egress | Description                                                    |
| -------  | ----------- |--------------- | -------------------------------------------------------------- |
| tcp      | 4243        | ingress        | Allow Docker Remote API                                        |
| tcp      | 32768-60999 | ingress        | Allow Docker Hostport Range                                    |
| tcp      | 22          | ingress        | Allow ssh                                                      |
| all      | all         | egress         | Allow all outgoing traffic                                     |

### Consul :
| Protocol | Port        | ingress/egress | Description                                                    |
| -------  | ----------- |--------------- | -------------------------------------------------------------- |
| HTTPS    | 443         | ingress        | Allow consul  UI                                               |
| HTTP     | 8500        | ingress        | Allow consul  UI                                               |
| tcp      | 8600        | ingress        | Allow to resolve DNS queries                                   |
| tcp, udp | 8301        | ingress        | Allow Serf LAN port                                            |
| tcp, udp | 8302        | ingress        | Allow Serf WAN port                                            |
| tcp      | 8300        | ingress        | Allow Server RPC address                                       |
| tcp      | 21000-21255 | ingress        | Allow for automatically assigned sidecar service registrations |
| tcp      | 22          | ingress        | Allow ssh                                                      |

### EKS :
| Protocol | Port        | ingress/egress | Description                                                    |
| -------  | ----------- |--------------- | -------------------------------------------------------------- |
| tcp      | 22          | ingress        | Allow ssh                                                      |

### Bastian Server :
| Protocol | Port        | ingress/egress | Description                                                    |
| -------  | ----------- |--------------- | -------------------------------------------------------------- |
| tcp      | 22          | ingress        | Allow ssh                                                      |
| all      | all         | egress         | Allow all outgoing traffic                                     |

### Project Terraform Deployments 
- [Terraform-VPC](terraform_vpc) - Creating VPC
- [Terraform-Jenkins](terraform_jenkins) - Creating Jenkins Master & Jenkins Slave
- [Terraform-Consul](/terraform_consul) - Creating Consul cluster
- [Terraform-EKS](/terraform_eks) - Creating EKS


### Links for dockerhub related images
- [Kandula](https://hub.docker.com/repository/docker/erandocker/ops-school-kandula) - docker pull erandocker/ops-school-kandula:tagname
- [Jenkins Slave Ubuntu-18.04](https://hub.docker.com/repository/docker/erandocker/jenkins-slave-ubuntu-18.4) - docker pull erandocker/jenkins-slave-ubuntu-18.4:tagname
- [Jenkins Slave Centos-7](https://hub.docker.com/repository/docker/erandocker/jenkins-slave-docker-centos-7) - docker pull erandocker/jenkins-slave-docker-centos-7:tagname

### Links for GitHub related repository
- [Terrafom VPC module](https://github.com/eranmos/ops-school-terraform-aws-vpc.git) - Terraform VPC module for AWS VPC, Subnets, Routing, NAT Gateway creation  
- [Kandula Application](git@github.com:eranmos/ops-school-kandula-project-app.git) - Code for Kandule Application
