variable "ports" {
  type    = map(number)
  default = {
    http  = 8080
    ssh   = 22
  }
}