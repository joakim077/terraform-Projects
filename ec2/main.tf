resource "aws_key_pair" "main" {
    public_key = file("~.ssh/ec2_key.pub")
    key_name = "ec2_key"
}


resource "aws_default_vpc" "main" {
  
}

resource "aws_security_group" "main" {
  name = "my_tf_sg"
  description = "Security group created by Terraform"
  vpc_id = aws_default_vpc.main.id

  ingress {
    description = "allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

   egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
     name = "tf-sg"
   }
}

resource "aws_instance" "main" {
  ami = "ami-id"
  instance_type = "t2.micro"
  key_name = aws_key_pair.main.key_name
  security_groups = [aws_security_group.main.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
}

