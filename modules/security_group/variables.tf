variable "allowed_ports" {
  description = "List of allowed inbound ports"
  type        = list(number)
  default     = [22, 80]
}

variable "allowed_cidrs" {
  description = "List of allowed CIDR blocks for inbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_id" {
  type        = string
  description = "vpc_id"
}

variable "sg_name" {
  type        = string
  description = "Security group name"
}
