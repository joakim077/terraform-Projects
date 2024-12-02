resource "aws_instance" "main" {
  count = 2
  ami = "ami-0ad21ae1d0696ad58"
  instance_type = "t2.micro"
  tags = {
    Name = "my-instance"
  }
}