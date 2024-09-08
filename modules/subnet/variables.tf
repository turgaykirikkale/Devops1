
variable "vpc_id" {
  type        = string
  description = "VPC ID."
  sensitive   = false
}
variable "type" {
  type        = string
  default     = ""
  description = "Type of subnets to create (`private` or `public`)."
}

variable "cidr_block" {
  type        = string
  default     = null
  description = "Base CIDR block which is divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)."
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)."
}

variable "availability_zone_index" {
  type        = number
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `prod-subnet` or `subnet`)."
}
variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}


