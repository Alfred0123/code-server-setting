data "aws_route53_zone" "this" {
  name = var.domain
}

# module "security_group" {
#   source = "./modules/terraform-aws-security-group"
#   # local path 의 경우에는 version 을 명시하지 않는듯 하다
#   # version = "~> 3.0"

#   name = "example"
#   description = "Security group for example usage with EC2 instance"
#   vpc_id = data.aws_vpc.default.id

#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   ingress_rules = ["http-80-tcp", "all-icmp", "ssh-tcp", "openvpn-https-tcp"]
#   egress_rules = ["all-all"]
# }

# module "ec2" {
#   source = "./modules/terraform-aws-ec2-instance"

#   instance_count = 1

#   key_name = aws_key_pair.web_admin.key_name

#   name          = "example-t2-unlimited"
#   ami           = data.aws_ami.ubuntu_linux.id
#   instance_type = "t2.micro"
#   cpu_credits   = "unlimited"
#   subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
#   //  private_ip = "172.31.32.10"
#   vpc_security_group_ids      = [module.security_group.this_security_group_id]
#   associate_public_ip_address = true

#   # custom variable
#   private_key_path = "~/.ssh/web_admin"
#   provisioner_init = {
#     source = "./provisioner/init.sh"
#     destination = "/tmp/init.sh"
#   }
#   provisioner_vpnserver = {
#     source = "./provisioner/vpnserver.sh"
#     destination = "/tmp/vpnserver.sh"
#   }
# }