##########
# OUTPUT
##########

output "bastion_server_public_dns" {
  value = aws_instance.bastion.public_dns
}
