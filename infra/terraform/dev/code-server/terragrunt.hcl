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
  subnet_id = dependency.vpc.outputs.subnet_id
  vpc_id = dependency.vpc.outputs.vpc_id
  key_name = "code-server"
  ami = "ami-0e9bfdb247cc8de84"
  # ami = "ami-0e9bfdb247cc8de84" # ubuntu 22.04 / 64비트 x86
  # ami = "ami-02a8e74d508493718" # ubuntu 22.04 / 64비트 Arm
  instance_type = "t3.medium"
  # instance_type = "t3.medium" # 2vCPU 4gi 0.052$/hr / 73원
  # instance_type = "t3.large" # 2vCPU 8gi 0.104$/hr / 147원
  # instance_type = "t3.xlarge" # 4vCPU 16gi 0.208$/hr / 295원
  # instance_type = "t3.2xlarge" # 8vCPU 32gi 0.416$/hr / 591원
  # instance_type = "c5a.xlarge" # 4vCPU 8gi 0.172$/hr / 244원
  # instance_type = "c5a.2xlarge" # 8vCPU 16gi 0.344$/hr / 489원
  # instance_type = "c5a.4xlarge" # 16vCPU 32gi 0.688$/hr / 978원
  volume_size = 10
}
