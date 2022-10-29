output "vpc" {
  value = module.vpc
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet_id" {
  value = module.vpc.public_subnets[0]
}

