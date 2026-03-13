module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  vpc_name           = var.vpc_name
  subnet_name        = var.subnet_name
  igw_name           = var.igw_name
  route_table_name   = var.route_table_name
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
  name   = "turjo-amazon-sg"

  ingress_rules = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    },
    {
      from_port = 3306
      to_port   = 3306
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  ]
}

module "sg_ubuntu" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
  name   = "turjo-ubuntu-sg"

  ingress_rules = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  ]
}

module "amazon_ec2" {
  source = "./modules/ec2"

  ami           = "ami-075b5421f670d735c"
  instance_type = "t3a.micro"
  subnet_id     = module.vpc.public_subnet_id
  key_name      = module.amazon_keypair.key_name
  sg_id         = module.sg_amazon.sg_id
  user_data     = file("user-data/amazon.sh")
  instance_name = "Turjo-AmazonLinux-Server"
}
module "ubuntu_ec2" {
  source = "./modules/ec2"

  ami           = "ami-0786adace1541ca80"
  instance_type = "t3a.micro"
  subnet_id     = module.vpc.public_subnet_id
  key_name      = module.ubuntu_keypair.key_name
  sg_id         = module.sg_ubuntu.sg_id
  user_data     = file("user-data/ubuntu.sh")
  instance_name = "Turjo-Ubuntu-Nginx-Server"
}