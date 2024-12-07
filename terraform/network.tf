resource "aws_lb" "this" {
  name               = format("%s-lb", var.project)
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "this" {
  name     = format("%s-lb-tg", var.project)
  port     = 5000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_security_group" "this" {
  name = format("%s-%s-sg", var.project, var.environment)
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
}
