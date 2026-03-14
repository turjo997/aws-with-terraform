resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = [var.sg_id]

  user_data = var.user_data

  associate_public_ip_address = true 
  user_data_replace_on_change = true
  
  tags = {
    Name = var.instance_name
  }
}