variable "vpc_id" {
  type      = string
  default   = "VPC id for route table"
  sensitive = false
}
variable "rt_name" {
  type      = string
  default   = "Route table name"
  sensitive = false
}

variable "is_public" {
  type        = bool
  description = "true = public, false = private"
  default     = true
}

variable "internet_gateway_id" {
  type        = string
  description = "Internet Gateway ID for Public Route Table"
}

variable "nat_gateway_id" {
  type        = string
  description = "NAT Gateway ID for Private Route Table"
}

variable "public_subnet_id" {
  type        = string
  description = "Public Subnet ID"
}

variable "private_subnet_id" {
  type        = string
  description = "Private Subnet ID"
}
