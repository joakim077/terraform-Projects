# Output in terminal will be printed from root module only

output "vpc-id"{
    value = module.vpc-module.vpc-id
}

output "public_subnets" {
  value = module.vpc-module.public_subnets
}

output "private_subnets" {
  value = module.vpc-module.private_subnets
}