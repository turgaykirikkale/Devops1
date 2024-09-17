
resource "aws_eip" "nat_gateway_eip" {
  domain     = "vpc"
  depends_on = [var.internet_gateway]
  tags = {
    Name = "demo_igw_eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = var.public_subnet_id
  tags          = var.tags
}
