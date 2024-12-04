module "vpc-module" {
  source = "./module-vpc"
  vpc_config = {
    cidr = "10.0.0.0/16"
    name = "my-vpc"
  }
  subnet_config = {
    subnet-1 = {
      cidr= "10.0.1.0/24"
      az = "ap-south-1a"
      public = true
    }
    subnet-2 = {
      cidr= "10.0.2.0/24"
      az = "ap-south-1b"
      public = false
    }
  }
}