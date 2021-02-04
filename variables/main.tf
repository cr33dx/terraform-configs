terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_pet" "server" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc${random_pet.server.id}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-${random_pet.server.id}"
  }
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh"
  description = "allow ssh"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet.id
  security_groups = [aws_security_group.sg.id]
}
