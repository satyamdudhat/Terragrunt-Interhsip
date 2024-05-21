remote_state {
  backend = "s3"
  config = {
    bucket         = "satyam-terragrunts"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    profile        = "satyam"
  }
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "ap-south-1"
  profile = "satyam"
}
EOF
}