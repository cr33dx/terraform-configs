terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                     = var.vpc_az
  private_subnets          = [var.vpc_prisubnet]
  public_subnets           = var.vpc_pubsubnet
  map_public_ip_on_launch = true
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh"
  description = "allow ssh"
  vpc_id      = module.vpc.vpc_id

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

module "instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "aws-instance"
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id             = module.vpc.public_subnets[0]
}
