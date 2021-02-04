provider "aws" {
  region = "us-west-2"
}

provider "random" {}

resource "random_pet" "server_name" {}

resource "aws_instance" "web_server" {
  ami           = "ami-a0cfeed8"
  instance_type = "t2.micro"
  user_data     = file("init-script.sh")
  tags = {
    Name : random_pet.server_name.id
  }
}

output "domain-name" {
  value = aws_instance.web_server.public_dns
}

output "application-url" {
  value = "${aws_instance.web_server.public_dns}/index.php"
}
