provider "aws" {
  region = "ap-south-2"
}

# Get latest Ubuntu 22.04 AMI automatically
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (Ubuntu official)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "devops_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "devops"

  tags = {
    Name = "DevOps-Lab-Server"
  }
}

output "public_ip" {
  value = aws_instance.devops_server.public_ip
}

