include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../modules/code-server"
}

dependency "vpc" {
  config_path = "../vpc"
}


# vpc_name = dependency.vpc-network.outputs.typed_vpc_name
# subnet_name = dependency.vpc-network.outputs.typed_private_subnet_name

inputs = {
  name = "code-server"
}
