resource "aws_iam_role" "role_s3_to_ec2" {
  name = "ROLE__S3_ReadOnly_ON_EC2"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge({Name = join("-",tolist(["AIM_ROLE_S3", var.marca, var.environment]))},local.tags)
}

resource "aws_iam_role_policy" "policy_s3_to_ec2" {
  name = "policy_role_s3_to_ec2"
  role = aws_iam_role.role_s3_to_ec2.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}

resource "aws_iam_instance_profile" "profile_to_ec2" {
  name = "PROFILE_ROLE__S3_ReadOnly_ON_EC2"
  role = "${aws_iam_role.role_s3_to_ec2.name}"
}