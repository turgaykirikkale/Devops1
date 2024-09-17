output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "vpc_name" {
  description = "The vpc name"
  value       = var.vpc_name
}

