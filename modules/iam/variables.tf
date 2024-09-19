variable "s3_bucket_arn" {
  type        = string
  description = "S3 Bucket ARN"
}
variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name"
}


variable "role_name" {
  type        = string
  description = "The name of the IAM role"
}

variable "instance_profile_name" {
  type        = string
  description = "The name of the instance profile"
}


