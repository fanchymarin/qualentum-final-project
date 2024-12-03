resource "aws_instance" "this" {
	ami = "ami-0427090fd1714168b"
	instance_type = "t2.micro"
	tags = {
		Name = "lab3-tf-instance"
		Scope = "lab3"
	}
	key_name = "vockey"
	vpc_security_group_ids = [ aws_security_group.this.id ]
	depends_on = [ aws_security_group.this ]
}

resource "aws_security_group" "this" {
	name = "lab3-tf-sg"
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Scope = "lab3"
	}
}