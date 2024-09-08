variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "vpc_name" {
  type    = string
  default = "000001"
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "private_subnet" {
  type    = string
  default = "private_subnet_1"
}
variable "public_subnets" {
  type    = string
  default = "public_subnet_1"
}
