#################
# Load Balancer #
#################

resource "aws_lb" "jenkins" {
  name                       = "jenkins-alb-${local.env_name}"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [data.aws_subnet.public-us-east-1a.id, data.aws_subnet.public-us-east-1b.id]
  security_groups            = [aws_security_group.jenkins.id]

  tags = local.common_tags
}

#listener is configured to accept HTTP client connections.
resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.jenkins.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins-server.arn
  }
}

resource "aws_lb_target_group" "jenkins-server" {
  name      = "jenkins-server-group"
  port      = 8080
  protocol  = "HTTP"
  vpc_id    = data.aws_vpc.ops-school-prod-vpc.id

  health_check {
    enabled = true
    path    = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    port                = 8080
  }
  tags = {
     Name = "jenkins-target-group"
     Owner = local.owner
     Environment = local.env_name
  }
}

resource "aws_lb_target_group_attachment" "jenkins_server" {
  target_group_arn = aws_lb_target_group.jenkins-server.arn
  target_id        = aws_instance.jenkins-server.id
  port             = 8080
}

