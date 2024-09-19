
# Route Table oluşturma (dinamik olarak public veya private)
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = var.internet_gateway_id != null ? var.internet_gateway_id : null
    nat_gateway_id = var.nat_gateway_id != null ? var.nat_gateway_id : null
  }
  tags = {
    Name = "${var.rt_name}/ ${var.vpc_id}"
  }
}

# Subnet ile Route Table ilişkilendirme
resource "aws_route_table_association" "dynamic_association" {
  subnet_id      = var.is_public ? var.public_subnet_id : var.private_subnet_id
  route_table_id = aws_route_table.route_table.id
}
