include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../modules/code-server"
}

inputs = {
  service_name = "${include.root.locals.service}"
}
