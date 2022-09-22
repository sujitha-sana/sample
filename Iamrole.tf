# resource "aws_iam_role" "ecr-role" {
#   name = "ecr-role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     ecr-role = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "ecr-role"
#   }
# }

# #policy

# resource "aws_iam_policy" "ecr-role-policy" {
#   name        = "ecr-role"
#   path        = "/"
#   description = "My test policy"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     ecr-role = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "s3:*",
#           "ecr:*"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecr-role" {
#   role       = aws_iam_role.ecr-role.name
#   policy_arn = aws_iam_policy.ecr-role-policy.arn
# }

# resource "aws_iam_instance_profile" "ecr-role" {
#   name = "ecr-role_profile"
#   role = aws_iam_role.ecr-role.name
# }