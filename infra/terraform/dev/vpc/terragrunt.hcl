include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../modules/vpc"
}

inputs = {
  name = "code-server"
}
