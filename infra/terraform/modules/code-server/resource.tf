//
// route53
//
data "aws_route53_zone" "this" {
  name = var.domain
}
resource "aws_eip" "this" {
  instance = module.ec2_instance.id
  vpc      = true
}
resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${var.name}.${var.domain}"
  type    = "A"
  ttl     = 10
  records = [aws_eip.this.public_ip]
}

//
// security group
//
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}"
  description = "${var.name} default security group"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  # common rule
  ingress_rules            = ["ssh-tcp", "https-443-tcp", "http-80-tcp"]
  # custom rule
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "code-server"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 51820
      to_port     = 51820
      protocol    = "udp"
      description = "wireguard"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules            = ["all-all"]
}

# 참고 / https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/blob/master/examples/complete/main.tf
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "${var.name}"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = false
  vpc_security_group_ids = ["${module.security_group.security_group_id}"]
  subnet_id              = var.subnet_id

  user_data_base64 = "${data.template_cloudinit_config.this.rendered}"
  # user_data_replace_on_change = true

  root_block_device = [
    {
      volume_size = var.volume_size
      volume_type = "gp2"
    }
  ]

  tags = {
    # Terraform   = "true"
    # Environment = "dev"
  }
}

data "template_cloudinit_config" "this" {
  gzip = true
  base64_encode = true

  part {
    content_type = "text/cloud-config" # "text/x-shellscript"
    # filename = "code-server-config.yaml"
    # content = "${data.template_file.code_server_config.rendered}"

    #! 주의사항 / path 값을 /home/ubuntu 로 잡으면, 유저가 생기기 전에 ubuntu 폴더가 생기게 됨으로 주의!
    content = jsonencode({
      write_files = [
        {
          encoding = "b64"
          # content = filebase64("${data.template_file.code_server_config.rendered}")
          content = filebase64("${path.module}/config.yaml")
          # content = data.template_file.code_server_config.rendered
          owner = "root:root"
          path = "/tmp/config.yaml"
          permissions = "0755"
        }
      ]
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = <<EOF
#!/bin/bash
/bin/echo "test" > /tmp/test.log
sudo /bin/echo "sudo" > /tmp/sudo.log
sudo echo "echo" > /tmp/echo.log
EOF
  }

  # part {
  #   content_type = "text/x-shellscript"
  #   content = "echo \"test\" > test.log"
  # }
}

data "template_file" "code_server_config" {
  template = file("${path.module}/config.yaml")
  vars = {
    # password = var.password
  }
}

//
// EBS volume
//
# data "aws_subnet" "this" {
#   id = var.subnet_id
# }
# resource "aws_volume_attachment" "this" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.this.id
#   instance_id = module.ec2_instance.id
# }
# resource "aws_ebs_volume" "this" {
#   availability_zone = data.aws_subnet.this.availability_zone
#   size              = var.volume_size
#   # tags = {}
# }