remote_state {
  backend = "s3"
  config = {
    bucket         = "${local.tf_bucket}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    profile        = "${local.aws_profile}"
  }
}

locals {
  tf_bucket   = get_env("TF_VAR_tf_bucket")
  aws_profile = get_env("TF_VAR_aws_profile")
  aws_region  = get_env("TF_VAR_aws_region")
}