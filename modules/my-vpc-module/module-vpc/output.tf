# Output Neccessary info

output "vpc-id" {
  value = aws_vpc.main.id
}


locals {
# format subnet subnet1 = {id= , az =}
  public_subnets = {
    for key, config in local.public_subnet : key => {
        subnet_id = aws_subnet.main[key].id
        az = aws_subnet.main[key].id
    }
  }

  private_subnets = {
    for key, config in local.private_subnet : key => {
        subnet_id = aws_subnet.main[key].id
        az = aws_subnet.main[key].id
    }
  }
}
#Subnet details

output "public_subnets" {
  value = local.public_subnets
}

output "private_subnets" {
  value = local.private_subnets
}