data "aws_security_group" "this" {
	name = "lab3-tf-sg"
}

data "aws_elb" "this" {
	name = "lab3-elb"
}

resource "aws_instance" "this" {
	ami = "ami-0427090fd1714168b"
	instance_type = "t2.micro"
	tags = {
		Name = "lab3-tf-instance"
		Scope = "lab3"
	}
	key_name = "vockey"
	vpc_security_group_ids = [ data.aws_security_group.this.id ]
}

resource "aws_elb_attachment" "elb_attachment" {
  elb      = data.aws_elb.this.id
  instance = aws_instance.this.id
}