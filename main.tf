module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}


module "amazon_keypair" {
  source = "./modules/keypair"

  key_name     = "amazon-pub-key"
  private_file = "amazon-ec2-key.pem"
}

module "ubuntu_keypair" {
  source = "./modules/keypair"

  key_name     = "ubuntu-pub-key"
  private_file = "ubuntu-ec2-key.pem"
}


module "sg_amazon" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
  name   = "amazon-sg"
}

module "sg_ubuntu" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
  name   = "ubuntu-sg"
}

module "amazon_ec2" {
  source = "./modules/ec2"

  ami           = "ami-075b5421f670d735c"
  instance_type = "t3a.micro"
  subnet_id     = module.vpc.public_subnet_id
  key_name      = var.key_name
  sg_id         = module.sg_amazon.sg_id
  user_data     = file("user-data/amazon.sh")
}

module "ubuntu_ec2" {
  source = "./modules/ec2"

  ami           = "ami-0786adace1541ca80"
  instance_type = "t3a.micro"
  subnet_id     = module.vpc.public_subnet_id
  key_name      = var.key_name
  sg_id         = module.sg_ubuntu.sg_id
  user_data     = file("user-data/ubuntu.sh")
}