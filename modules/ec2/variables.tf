variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "key_name" {}
variable "user_data" {}
variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}