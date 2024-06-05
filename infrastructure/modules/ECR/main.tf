# ECR
resource "aws_ecr_repository" "serverless_ecr_repository" {
  name                 = var.ecr_name
  image_tag_mutability = var.image_tag_mutability
}
