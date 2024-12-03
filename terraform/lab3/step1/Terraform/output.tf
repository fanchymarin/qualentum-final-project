data "aws_instances" "current" {
	instance_tags = {
		Scope = "lab3"
	}
}

data "aws_instance" "details" {
  for_each = toset(data.aws_instances.current.ids)
  instance_id = each.value
}

output "all_instances" {
  value = {
    for instance in data.aws_instances.current.ids :
    instance => data.aws_instance.details[instance].instance_state
  }
  description = "ID y estado de todas las instancias en la cuenta"
}

output "instance_public_ip" {
	value = aws_instance.this.public_ip
}