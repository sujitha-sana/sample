# resource "aws_ecr_repository" "Apache" {
#   name                 = "ImageApache"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }