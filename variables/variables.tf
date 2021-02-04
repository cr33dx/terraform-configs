variable "aws_region" {
  description = "aws region"
  type = string
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type = string
}

variable "ami_id" {
  description = "ami id"
  type = string
  default = "ami-830c94e3"
}

variable "public_subnet" {
  description = "public subnet"
  type= list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}
