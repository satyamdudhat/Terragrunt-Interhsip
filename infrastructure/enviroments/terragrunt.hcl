locals {
  aws_profile = "satyam"
  default_region = "ap-south-1"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "satyam-terragrunts"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = locals.default_region
    encrypt        = true
    profile        = locals.aws_profile
  }
}


