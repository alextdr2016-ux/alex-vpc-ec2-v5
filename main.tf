terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  igw_name = "alex-igw-v5"
}

# NAT Gateway Module
module "nat_gateway" {
  source = "./modules/nat_gateway"

  public_subnet_id = module.subnet.public_subnet_id
  igw_id           = module.vpc.igw_id
  eip_name         = "alex-nat-eip-v5"
  nat_gw_name      = "alex-nat-gw-v5"
}

# Subnet Module
module "subnet" {
  source = "./modules/subnet"

  vpc_id                = module.vpc.vpc_id
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  public_subnet_name    = var.public_subnet_name
  private_subnet_name   = var.private_subnet_name
  availability_zone     = var.availability_zone
  igw_id                = module.vpc.igw_id
  nat_gateway_id        = module.nat_gateway.nat_gateway_id
  public_rt_name        = "alex-public-rt-v5"
  private_rt_name       = "alex-private-rt-v5"
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  vpc_id                  = module.vpc.vpc_id
  sg_name                 = var.security_group_name
  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  public_subnet_id        = module.subnet.public_subnet_id
  private_subnet_id       = module.subnet.private_subnet_id
  public_instance_name    = var.instance_name
  private_instance_name   = var.private_instance_name
}