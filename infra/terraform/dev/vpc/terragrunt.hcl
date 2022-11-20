include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../modules/vpc"
}

#! arguments
inputs = {
  name = "code-server"
}
