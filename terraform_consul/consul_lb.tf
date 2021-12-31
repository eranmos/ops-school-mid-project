#################
# Load Balancer #
#################

resource "aws_lb" "consul" {
  name                       = "consul-alb-${local.env_name}"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [data.aws_subnet.public-us-east-1a.id, data.aws_subnet.public-us-east-1b.id]
  security_groups            = [aws_security_group.consul-server.id]

  tags = local.common_tags
}

#listener is configured to accept HTTP client connections.
resource "aws_lb_listener" "consul" {
  load_balancer_arn = aws_lb.consul.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.consul-server.arn
  }
}

resource "aws_lb_target_group" "consul-server" {
  name      = "consul-server-group"
  port      = 8500
  protocol  = "HTTP"
  vpc_id    = data.aws_vpc.ops-school-prod-vpc.id

  health_check {
    enabled = true
    path    = "/ui/opsschool/services"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    port                = 8500
  }
  tags = {
     Name = "consul-target-group"
     Owner = local.owner
     Environment = local.env_name
  }
}

resource "aws_lb_target_group_attachment" "consul_server" {
  count = length(aws_instance.consul-server)
  target_group_arn = aws_lb_target_group.consul-server.arn
  target_id        = aws_instance.consul-server[count.index].id
  port             = 8500
}