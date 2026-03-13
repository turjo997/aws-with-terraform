variable "aws_region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "public_key_path" {
  default = "~/..ssh/id_rsa.pub"
}

variable "vpc_name" {
  default = "turjo-main-vpc"
}
variable "subnet_name" {
  default = "turjo-public-subnet"
}

variable "igw_name" {
  default = "turjo-igw"
}

variable "route_table_name" {
  default = "turjo-public-rt"
}
