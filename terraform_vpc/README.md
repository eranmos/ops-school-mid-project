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

Below table will help you determine which value should be in each variable's inside the `.tfvars` file.