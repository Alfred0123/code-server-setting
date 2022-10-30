output "security_group" {
  value = module.security_group
}

output "ec2_instance" {
  value = module.ec2_instance
}

output "ip" {
  value = aws_eip.this
}

# output "test" {
#   value = data.aws_subnet.this
# }

