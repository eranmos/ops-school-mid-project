##########
# Route53
##########

# "A" name record for jenkins server
resource "aws_route53_record" "jenkins-server" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.jenkins_dns
  type        = "A"

  alias {
    name                   = aws_lb.jenkins.dns_name
    zone_id                = aws_lb.jenkins.zone_id
    evaluate_target_health = true
  }
}
