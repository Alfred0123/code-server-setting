module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.name}-vpc"
  cidr = "192.168.0.0/16"

  azs             = ["${var.region}a"]
  # private_subnets = ["192.168.1.0/24", "192.168.2.0/24"]
  public_subnets  = ["192.168.11.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_ipv6 = false

  # enable_nat_gateway     = true
  # single_nat_gateway     = true
  # one_nat_gateway_per_az = false
  
  # 외부 nat gateway 사용하려면 아래 활성화
  # reuse_nat_ips       = true   
  # external_nat_ip_ids = aws_eip.nat.*.id

  public_subnet_tags = {
    # Name = "subnet-public"
  }

  tags = {
    # Owner       = "nanafa"
    # Environment = "dev"
  }

  vpc_tags = {
    # Name = "nanafa-vpc-dev"
  }
}
