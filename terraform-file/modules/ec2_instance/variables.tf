variable "instance_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "security_ports" {
  type = list(number)
}
variable "install_script" {}
variable "subnet_id" {}
variable "key_name" {}
variable "vpc_id" {}