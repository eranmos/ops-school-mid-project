<h1 align="center">Terraform VPC</h1>

<h6 align="center">Terraform which creates VPC resources on AWS.</h6>

## Table of Contents

- [Prerequisites](#prerequisites)
- [Deploying Instructions](#deploying-instructions)
- [Variables References Table](#variables-references-table)

## Prerequisites
To deploy all infrastructure you will need below application to be installed on your workstation/server
+ Install [GIT](https://github.com/git-guides/install-git) on your workstation/server
+ Install [Terraform v1.1.2](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server


## Deploying Instructions

  Run the following:
   ```bash
   terraform init
   terraform apply --auto-approve
   ```

## Variables References Table

In below table you can see `variables.tf` file details:

| Variable | Description |
| -------- | ----------- |
| aws_region | AWS working region |
| availablity_zone_a | AWS availablity zone X |
| availablity_zone_b | AWS availablity zone X |
| private_dns_name | private dns name for dhcp options domain name |
| network_address_space | for cidr |
| public_subnet1_address_space | public ip address allocation for subnet X |
| private_subnet1_address_space | Private ip address allocation for subnet X |
| public_subnet2_address_space | public ip address allocation for subnet y |
| private_subnet2_address_space | Private ip address allocation for subnet y |
| aws_cli_profile | your awscli profile config |
| env_name | tag for your env name |
| owner | tag for owner name |
| project | tag for Project name |
