resource "aws_autoscaling_group" "this" {
  availability_zones =  ["us-east-1a", "us-east-1b", "us-east-1c", 
                        "us-east-1d", "us-east-1e", "us-east-1f"]
  name               = format("%s-asg", var.project)

  depends_on         = [ aws_launch_template.this ]
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

resource "aws_launch_template" "this" {
  name = format("%s-%s-tp", var.project, var.environment)

  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  image_id = "ami-0e2c8caa4b6378d8c"
  instance_type = "t3.medium"
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
