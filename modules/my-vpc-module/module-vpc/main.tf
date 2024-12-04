resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr
  tags = {
    name = var.vpc_config.name
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  for_each = var.subnet_config
  cidr_block = each.value.cidr
  availability_zone = each.value.az

  tags = {
    name = each.key
  }
}

# make a local to pair public subnets
locals {
  public_subnet = {
    for key, config in var.subnet_config : key => config if config.public
  }
  private_subnet = {
    for key, config in var.subnet_config : key => config if !config.public
  }
} 

# Internet Gateway if there are any Public subnets
resource "aws_internet_gateway" "main" {
  count = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    name = "my-igw"
  }
}
#Routing Table for public subnets
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  count =  length(local.public_subnet) > 0 ? 1 : 0
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
}

# Subnet association for Public subnet to public route table
resource "aws_route_table_association" "main" {
  for_each = local.public_subnet #public_subnet={} private_subnet={}

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id

  depends_on = [ aws_route_table.main ]
}
