provider "aws" {
  profile = var.profile
}

# ApiGateway Table Resource Code
module "api_gateway" {
  source           = "../modules/Api_Gateway"
  api_name         = "${var.project}-${var.env}-api"
  lambda_function_uri = module.lambda_function.invoke_arn
  lambda_function_name    = module.lambda_function.arn
  api_path_name    = [ "status", "employee", "employees" ]

  providers = {
    aws = aws
  }
}


# DynamoDB Table Resource Code
module "dyanmo_db" {
  source = "../modules/Dynamo_DB"
  table_name = "${var.project}-${var.env}-employeetable"
  hash_key_id = "employeeid"
  providers = {
    aws = aws
  }
}


# ECR Repo Code
module "ecr_repo" {
  source = "../modules/ECR"
  ecr_name = "${var.project}-${var.env}-ecr"
  image_tag_mutability = "MUTABLE"
  providers = {
    aws = aws
  }
}


# Lambda Code
module "lambda_function" {
  lambda_function_name = "${var.project}-${var.env}-lambdaproject"
  source = "../modules/Lambda_Function"
  lambda_image_uri = "${module.ecr_repo.repository_url}:latest"
  iam_role_name = "${var.project}-${var.env}-iamrole"
  ecr_access_policy = "${var.project}-${var.env}-ecraccess"
  dyanmodb_access_policy = "${var.project}-${var.env}-dyanmodbaccess"
  cloudwatch_access_policy = "${var.project}-${var.env}-cloudwatchaccess"
  providers = {
    aws = aws
  }
}

# terraform {
#   backend "s3" {
#     bucket = "satyam-terragrunts"
#     key    = "terraform.tfstate"
#     region = "ap-south-1"
#     profile = "satyam"
#   }
# }



terraform {
  backend "s3" {
    
  }
}