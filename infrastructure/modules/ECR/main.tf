# ECR
resource "aws_ecr_repository" "serverless_ecr_repository" {
  name = var.ecr_name
  image_tag_mutability = var.image_tag_mutability 
}

resource "null_resource" "execute_script" {
  depends_on = [ aws_ecr_repository.serverless_ecr_repository ]
  provisioner "local-exec" {
    command = var.imagepush_script_path
  }
}
