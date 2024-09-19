resource "aws_iam_role" "ec2_s3_access_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "s3_access_role"
  }
}

resource "aws_iam_policy" "s3_iam_access_policy" {
  name = "s3_iam_access_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Statement1",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        "Resource" : ["${var.s3_bucket_arn}", "${var.s3_bucket_arn}/*"]
      }
    ]
  })
}

//IAM Role policy Attach

resource "aws_iam_role_policy_attachment" "ec_2_s3_attach" {
  role       = aws_iam_role.ec2_s3_access_role.name
  policy_arn = aws_iam_policy.s3_iam_access_policy.arn
}

# Instance Profile create
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.ec2_s3_access_role.name
  name = var.instance_profile_name
}




/*

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-access-policy"
  description = "Policy to give EC2 instance access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Effect   = "Allow"
      Resource = "${var.s3_bucket_arn}/*"
    }]
  })
}
*/

/*
# IAM Role'a policy attach
resource "aws_iam_role_policy_attachment" "ec2_attach_s3_policy" {
  role       = aws_iam_role.ec2_s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
*/





