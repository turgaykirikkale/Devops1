variable "vpc_name" {
  type        = string
  description = "Name to give VPC. Note: does not effect subnet names, which get assigned name based on name_prefix."
}
variable "vpc_cidr_block" {
  description = "IPv4 CIDR range to assign to VPC if creating VPC or to associate as a secondary IPv6 CIDR. Overridden by var.vpc_id output from data.aws_vpc."
  type        = string
}
variable "vpc_tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
