variable "ami_id" {
  type = string
  default = "ami-a0cfeed8"
}
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_az" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_prisubnet" {
  type    = string
  default = "10.0.1.0/24"
}

variable "vpc_pubsubnet" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}
