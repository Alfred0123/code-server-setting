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

//
// ec2
//
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

  # user_data_base64 = "${data.template_cloudinit_config.this.rendered}"
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

resource "null_resource" "init" {
  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file("./keys/code-server.pem")}"
    timeout     = "2m"
    host = aws_eip.this.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ubuntu/init"
    ]
  }

  # code-server
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/.config/code-server"
    ]
  }
  provisioner "file" {
    source = "./init/code-server-config.yaml"
    destination = "/home/ubuntu/init/code-server-config.yaml"
  }
  provisioner "file" {
    source = "./init/code-server-install.sh"
    destination = "/home/ubuntu/init/code-server-install.sh"
  }

  # docker 
  provisioner "file" {
    source = "./init/docker-install.sh"
    destination = "/home/ubuntu/init/docker-install.sh"
  }

  # minikube 
  provisioner "file" {
    source = "./init/minikube-install.sh"
    destination = "/home/ubuntu/init/minikube-install.sh"
  }

  # traefik
  provisioner "file" {
    content = data.template_file.traefik_config.rendered
    destination = "/home/ubuntu/init/traefik-config.yaml"
  }
  provisioner "file" {
    source = "./init/docker-compose.yaml"
    destination = "/home/ubuntu/init/docker-compose.yaml"
  }

  # aws-cli
  provisioner "file" {
    source = "./init/aws-cli-install.sh"
    destination = "/home/ubuntu/init/aws-cli-install.sh"
  }

  # terraform
  provisioner "file" {
    source = "./init/terraform-install.sh"
    destination = "/home/ubuntu/init/terraform-install.sh"
  }

  depends_on = [
    module.ec2_instance, aws_eip.this
  ]
}

resource "null_resource" "install" {
  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file("./keys/code-server.pem")}"
    timeout     = "2m"
    host = aws_eip.this.public_ip
  }
  
  # code-server
  provisioner "remote-exec" {
    inline = [
      "sh /home/ubuntu/init/code-server-install.sh"
    ]
  }

  # docker
  provisioner "remote-exec" {
    inline = [
      "sh /home/ubuntu/init/docker-install.sh"
    ]
  }

  # minikube
  provisioner "remote-exec" {
    inline = [
      "sh /home/ubuntu/init/minikube-install.sh"
    ]
  }

  # traefik
  provisioner "remote-exec" {
    inline = [
      "cd init",
      "docker-compose up -d"
    ]
  }

  # aws-cli
  provisioner "remote-exec" {
    inline = [
      "sh /home/ubuntu/init/aws-cli-install.sh"
    ]
  }

  # terraform
  provisioner "remote-exec" {
    inline = [
      "sh /home/ubuntu/init/terraform-install.sh"
    ]
  }

  depends_on = [
    null_resource.init
  ]
}

data "template_file" "traefik_config" {
  template = file("${path.module}/init/traefik-config.yaml")
  vars = {
    DOMAIN = "${var.name}.${var.domain}"
  }
}

//
// EBS volume / root volume 외의, 외부 volume 이 필요한 경우
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