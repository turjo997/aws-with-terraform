output "amazon_public_ip" {
  value = aws_instance.amazon_linux.public_ip
}

output "ubuntu_public_ip" {
  value = aws_instance.ubuntu.public_ip
}