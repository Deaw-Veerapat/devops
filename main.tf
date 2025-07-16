terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

data "http" "my_ip" { #find my ip
  url = "https://api.ipify.org?format=text"
}
# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "jenkin_keypair" {
  key_name = "jenkin_keypair"
  public_key = tls_private_key.rsa-4096.public_key_openssh
}
# Create a VPC
resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.vpc_main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_security_group" "sg1" {
  name="jenkin"
  vpc_id = aws_vpc.vpc_main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "jenkin_ec2" {
  ami = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub1.id
  key_name = aws_key_pair.jenkin_keypair.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  associate_public_ip_address = true
}
output "private_key" {
  value = tls_private_key.rsa-4096.private_key_pem
  sensitive = true
}
output "public_ip" {
  value = aws_instance.jenkin_ec2.public_ip
}