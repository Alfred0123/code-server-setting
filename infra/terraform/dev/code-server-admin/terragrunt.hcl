include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../modules/code-server-admin"
}

dependency "vpc" {
  config_path = "../vpc"
}

#! arguments
dependency "code_server" {
  config_path = "../code-server"
}
#! arguments
inputs = {
  name = "code-server-admin"
  subnet_id = dependency.vpc.outputs.subnet_id
  vpc_id = dependency.vpc.outputs.vpc_id
}
