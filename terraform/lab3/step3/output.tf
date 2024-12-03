output "all_instances_attached" {
  value = [ for instance in data.aws_elb.this.instances : instance ]
  description = "ID y estado de todas las instancias en la cuenta"
}