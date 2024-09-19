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
  type        = list(string)
  description = "List of security groups to associate with the instance"
  default     = []
}

variable "has_iam_role" {
  type        = bool
  description = "İf has role use iam_role_profile"
  default     = false
}
variable "instance_profile" {
  type        = string
  description = "The IAM instance profile to attach to the EC2 instance"
  default     = null
}

variable "user_data_script" {
  type        = string
  description = "Control for .txt file creating, pushing and publishing "
  default     = null
}
