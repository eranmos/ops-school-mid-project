<h1 align="center">Terraform Consul</h1>

<h6 align="center">Terraform which creates Consul Master Cluster on AWS.</h6>

## Jenkins Infrastructure architecture diagram
![architecture_diagram]()

## Application diagram
![app_diagram]()


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
| aws_cli_profile | your awscli profile config |
| key_name | your pem key to access via ssh  |
| consul_instances_count | numbers of consul servers |
| consul_instance_type | The type of the ec2 |
| ami | ami (ubuntu 18) to use  |
| aws_registered_domains | your aws registered domains |
| consul_dns | your aws domains name for Consul GUI |
| default_s3_bucket | AWS s3 bucket for provisioning |
| env_name | tag for your env name |
| owner | tag for owner name |
| project | tag for Project name |