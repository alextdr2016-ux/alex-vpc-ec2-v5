resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = var.eip_name
  }

  depends_on = [var.igw_id]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = var.nat_gw_name
  }

  depends_on = [var.igw_id]
}
