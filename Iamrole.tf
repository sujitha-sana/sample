resource "aws_iam_role" "version" {
  name = "cicd"

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

  tags = {
    tag-key = "cicd"
  }
}

#policy

resource "aws_iam_policy" "version-policy" {
  name        = "version"
  path        = "/"
  description = "My test policy"

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

resource "aws_iam_role_policy_attachment" "version" {
  role       = aws_iam_role.version.name
  policy_arn = aws_iam_policy.version-policy.arn
}

resource "aws_iam_instance_profile" "version" {
  name = "version_profile"
  role = aws_iam_role.version.name
}