# ECR
resource "aws_ecr_repository" "serverless_ecr_repo" {
  name = var.ecr_name
  image_tag_mutability = var.image_tag_mutability 
}

# resource "null_resource" "execute_script" {
#   depends_on = [ aws_ecr_repository.ecr_repo ]
#   provisioner "local-exec" {
#     command = "bash scripts/image_push_code_master.sh "
#   }
# }
