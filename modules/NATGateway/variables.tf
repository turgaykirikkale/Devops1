variable "public_subnet_id" {
  type        = string
  description = "NAT Gateway'in yerleştirileceği public subnet ID'si"
}

variable "tags" {
  type        = map(string)
  description = "Kaynaklar için isteğe bağlı etiketler"
  default     = {}
}

variable "internet_gateway" {
  type          = string
  description = "İnternetGateway Info"
}
