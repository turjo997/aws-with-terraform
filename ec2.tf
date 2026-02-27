resource "aws_instance" "amazon_linux" {
  ami           = "ami-075b5421f670d735c"
  instance_type = "t3a.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = aws_key_pair.turjo_ec2_key1.key_name
  vpc_security_group_ids = [aws_security_group.turjo_amazon_sg.id]

  user_data = file("user-data/amazon.sh")

  tags = {
    Name = "Turjo-AmazonLinux-Server"
  }
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0786adace1541ca80"
  instance_type = "t3a.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = aws_key_pair.turjo_ec2_key2.key_name
  vpc_security_group_ids = [aws_security_group.turjo_ubuntu_sg.id]

  user_data = file("user-data/ubuntu.sh")

  tags = {
    Name = "Turjo-Ubuntu-Server"
  }
}