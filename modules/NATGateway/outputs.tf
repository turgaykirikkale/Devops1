# NAT Gateway ID'yi çıktı olarak ver
output "nat_gateway_id" {
  description = " NAT Gateway ID"
  value       = aws_nat_gateway.nat_gateway.id
}

# EIP adresini çıktı olarak ver
output "nat_eip_public_ip" {
  description = " Elastic IP address"
  value       = aws_eip.nat_gateway_eip.public_ip
}
