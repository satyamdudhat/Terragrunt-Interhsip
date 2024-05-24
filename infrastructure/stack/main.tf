provider "aws" {
  profile = "satyam"
}

# ApiGateway Table Resource Code
module "api_gateway" {
  source           = "../modules/Api_Gateway"
  api_name         = "${var.Project}-${var.Env}-api"
  uri              = module.lambda_function.invoke_arn
  function_name    = module.lambda_function.arn
  api_path_name    = [ "status", "employee", "employees" ]

  providers = {
    aws = aws
  }
}


# DynamoDB Table Resource Code
module "dyanmo_db" {
  source = "../modules/Dynamo_DB"
  table_name = "${var.Project}-${var.Env}-employeetable"
  hash_key_id = "employeeid"
  providers = {
    aws = aws
  }
}


# ECR Repo Code
module "ecr_repo" {
  source = "../modules/ECR"
  ecr_name = "${var.Project}-${var.Env}-ecr"
  image_tag_mutability = "MUTABLE"
  providers = {
    aws = aws
  }
}


# Lambda Code
module "lambda_function" {
  function_name = "${var.Project}-${var.Env}-lambdaproject"
  source = "../modules/Lambda_Function"
  image_uri = "${module.ecr_repo.repository_url}:latest"
  iam_role_name = "${var.Project}-${var.Env}-iamrole"
  ecr_access_policy = "${var.Project}-${var.Env}-ecraccess"
  dyanmodb_access_policy = "${var.Project}-${var.Env}-dyanmodbaccess"
  cloudwatch_access_policy = "${var.Project}-${var.Env}-cloudwatchaccess"
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