output "instance_profile_id" {
  description = "The name of the instance profile for EC2"
  value       = aws_iam_instance_profile.ec2_instance_profile.id
}

output "role_name" {
  description = "The IAM role name"
  value       = aws_iam_role.ec2_s3_access_role.name
}
