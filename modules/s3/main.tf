resource "aws_s3_bucket" "s3_bucket_001" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}
