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

resource "aws_launch_template" "this" {
  name = format("%s-%s-tp", var.project, var.environment)
  

  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  image_id = "ami-0453ec754f44f9a4a"


  instance_type = "t2.micro"

  key_name = "vockey"

  

  vpc_security_group_ids = [ aws_security_group.this.id ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Environment = var.environment
    }
  }

  user_data = filebase64("${path.module}/files/init/user-data.sh")
}

resource "aws_autoscaling_group" "this" {
  availability_zones =  ["us-east-1a", "us-east-1b", "us-east-1c", 
                        "us-east-1d", "us-east-1e", "us-east-1f"]
  name               = format("%s-asg", var.project)
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.project
    propagate_at_launch = true
  }
  target_group_arns = [ aws_lb_target_group.this.arn ]
}

resource "aws_lb" "this" {
  name               = format("%s-lb", var.project)
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids

  tags = {
    Environment = var.environment
  }
}