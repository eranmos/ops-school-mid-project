##########
# OUTPUT
##########

#Network VPC Info
output "ops-school-prod-vpc-id" {
  value = data.aws_vpc.ops-school-prod-vpc.id
}

#Network subnet Info
output "private-us-east-1a" {
  value = data.aws_subnet.private-us-east-1a.id
}

output "public-us-east-1a" {
  value = data.aws_subnet.public-us-east-1a.id
}

output "private-us-east-1b" {
  value = data.aws_subnet.private-us-east-1b.id
}

output "public-us-east-1b" {
  value = data.aws_subnet.public-us-east-1b.id
}

#Jenkins Server Info
output "jenkins_server_private_dns_name" {
  value = aws_instance.jenkins-server.*.private_dns
}

output "jenkins_server_private_ip_address" {
  value = aws_instance.jenkins-server.*.private_ip
}

#Jenkins Slave Info
output "jenkins_slave_private_dns_name" {
  value = aws_instance.jenkins-slave.*.private_dns
}

output "jenkins_slave_private_ip_address" {
  value = aws_instance.jenkins-slave.*.private_ip
}

#####  Load Balancer info ########
output "aws_jenkins_lb_public_dns" {
  description = "print out lb DNS name"
  value = aws_lb.jenkins.dns_name
}

#####  Route53 ########
output "my_aws_registered_domain_name" {
  description = "print my aws registered domain name"
  value = data.aws_route53_zone.my_aws_registered_domain.name
}
output "my_aws_registered_domain_id" {
  description = "print my aws registered domain id"
  value = data.aws_route53_zone.my_aws_registered_domain.id
}

output "jenkis_server_dns" {
  description = "print my jenkins aws registered domain id"
  value = aws_route53_record.jenkins-server.fqdn
}
