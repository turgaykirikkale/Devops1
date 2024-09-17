variable "subnet_id" {
  type        = string
  description = "SUBNET ID."
  sensitive   = false
}
variable "instance_type" {
  type        = string
  description = "Instance Type"
  sensitive   = false
}

variable "instance_name" {
  type        = string
  description = "Name of Instance"
}


variable "use_security_groups" {
  description = "List of security groups to associate with the instance"
  type        = list(string)
  default     = []
}
