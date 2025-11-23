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

resource "aws_vpc" "alex_vpc_v5" {
  cidr_block         = var.vpc_cidr
  instance_tenancy   = "default"
  enable_dns_support = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "alex_public_subnet_v5" {
  vpc_id                  = aws_vpc.alex_vpc_v5.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_internet_gateway" "alex_gw_v5" {
  vpc_id = aws_vpc.alex_vpc_v5.id

  tags = {
    Name = "alex_gw_v5"
  }
}

resource "aws_route_table" "alex_rt_v5" {
  vpc_id = aws_vpc.alex_vpc_v5.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.alex_gw_v5.id
  }

  tags = {
    Name = "alex_rt_v5"
  }
}

resource "aws_route_table_association" "alex_ra_v5" {
  subnet_id      = aws_subnet.alex_public_subnet_v5.id
  route_table_id = aws_route_table.alex_rt_v5.id
}

resource "aws_security_group" "alex_sg_v5" {
  name   = "alex_sg_v5"
  vpc_id = aws_vpc.alex_vpc_v5.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.alex_sg_v5.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.alex_sg_v5.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.alex_sg_v5.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.alex_sg_v5.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "alex_ec2_v5" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.alex_public_subnet_v5.id
  vpc_security_group_ids      = [aws_security_group.alex_sg_v5.id]
  associated_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}

# ELASTIC IP pentru NAT Gateway
resource "aws_eip" "nat_eip_v5" {
  domain = "vpc"

  tags = {
    Name = "alex-nat-eip-v5"
  }

  depends_on = [aws_internet_gateway.alex_gw_v5]
}

resource "aws_nat_gateway" "nat_gw_v5" {
  allocation_id = aws_eip.nat_eip_v5.id
  subnet_id     = aws_subnet.alex_public_subnet_v5.id
  tags = {
    Name = "alex-nat-gw-v5"
  }

  depends_on = [aws_internet_gateway.alex_gw_v5]
}

resource "aws_subnet" "alex_private_subnet_v5" {
  vpc_id                  = aws_vpc.alex_vpc_v5.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone

  tags = {
    Name = var.private_subnet_name
  }
}

# PRIVATE ROUTE TABLE (cu rută către NAT)
resource "aws_route_table" "alex_private_rt_v5" {
  vpc_id = aws_vpc.alex_vpc_v5.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_v5.id
  }

  tags = {
    Name = "alex-private-rt-v5"
  }
}


resource "aws_route_table_association" "alex_private_ra_v5" {
  subnet_id = aws_subnet.alex_private_subnet_v5.id
  route_table_id = aws_route_table.alex_private_rt_v5.id
}

resource "aws_instance" "alex_private_ec2_v5" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.alex_private_subnet_v5.id
  vpc_security_group_ids = [aws_security_group.alex_sg_v5.id]

  tags = {
    Name = var.private_instance_name
  }
}

