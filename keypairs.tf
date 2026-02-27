resource "tls_private_key" "turjo_amazon_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "amazon_private_key" {
  content         = tls_private_key.turjo_amazon_key.private_key_pem
  filename        = "amazon-ec2-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "turjo_ec2_key1" {
  key_name   = "amazon-pub-key"
  public_key = tls_private_key.turjo_amazon_key.public_key_openssh
}



resource "tls_private_key" "turjo_ubuntu_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ubuntu_private_key" {
  content         = tls_private_key.turjo_ubuntu_key.private_key_pem
  filename        = "ubuntu-ec2-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "turjo_ec2_key2" {
  key_name   = "ubuntu-pub-key"
  public_key = tls_private_key.turjo_ubuntu_key.public_key_openssh
}