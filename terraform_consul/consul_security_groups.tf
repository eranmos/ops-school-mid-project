####################
# Security Groups   #
####################

#######   Consul Server Security Group   ############

resource "aws_security_group" "consul-server" {
  name = "consul"
  vpc_id = data.aws_vpc.ops-school-prod-vpc.id
  description = "Allow Consul-Server inbound traffic"

  ingress {
    description = "This is used by clients to talk to the HTTPS API"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "DNS Interface Used to resolve DNS queries"
    from_port = 8600
    to_port = 8600
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP API This is used by clients to talk to the HTTP API"
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "LAN Serf: The Serf LAN port (TCP and UDP)"
    from_port = 8301
    to_port = 8301
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "LAN Serf: The Serf LAN port (TCP and UDP)"
    from_port = 8301
    to_port = 8301
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Wan Serf: The Serf WAN port (TCP and UDP)"
    from_port = 8302
    to_port = 8302
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Wan Serf: The Serf WAN port (TCP and UDP)"
    from_port = 8302
    to_port = 8302
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Server RPC address (TCP Only)"
    from_port = 8300
    to_port = 8300
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ssh from the world"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Sidecar Proxy Min: Inclusive min & max port number to use for automatically assigned sidecar service registrations"
    from_port = 21000
    to_port = 21255
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "consul-server"
    Owner = local.owner
    Environment = local.env_name

  }
}
