resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = [var.sg_id]

  user_data = var.user_data

  tags = {
    Name = "terraform-instance"
  }
}