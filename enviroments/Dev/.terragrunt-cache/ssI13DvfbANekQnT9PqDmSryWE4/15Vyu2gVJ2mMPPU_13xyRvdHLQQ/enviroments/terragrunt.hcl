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


