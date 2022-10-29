locals {
  project = get_env("PROJECT", "nanafa")
  region = get_env("REGION", "ap-northeast-2")
  env = get_env("ENV", "dev")
  service = get_env("SERVICE", "code-server-setting")
  # sample = get_env("SAMPLE", "sample")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${local.service}-terraform-state"
    key            = "${local.env}/${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "${local.service}-lock-table"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region      = "${local.region}"
}
EOF
}

inputs = {
  project = "${local.project}"
  region = "${local.region}"
  env = "${local.env}"
  service = "${local.service}"
  # sample = "${local.sample}"
}

