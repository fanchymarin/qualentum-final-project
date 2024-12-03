data "aws_region" "current" {}

data "aws_instances" "current" {
	instance_tags = {
		Scope = "lab3"
	}
}

data "aws_elb" "this" {
	name = "lab3-elb"
}

resource "aws_elb" "this" {
  name								= "lab3-elb"
  instances						= data.aws_instances.current.ids
	availability_zones	= ["${data.aws_region.current.name}a",
												"${data.aws_region.current.name}b",
												"${data.aws_region.current.name}c"]

  listener {
    instance_port     = 8080
    instance_protocol = "TCP"
    lb_port           = 80
    lb_protocol       = "TCP"
  }

  listener {
    instance_port      = 22
    instance_protocol  = "TCP"
    lb_port            = 25
    lb_protocol        = "TCP"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "lab3-elb"
  }
}