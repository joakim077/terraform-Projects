module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "tf-instance"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  ami = "ami-078264b8ba71bc45e"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}