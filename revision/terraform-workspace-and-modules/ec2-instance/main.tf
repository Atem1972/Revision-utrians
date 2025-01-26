provider "aws" {
  region = var.region
}



resource "aws_instance" "web1" {
  ami = var.ami
  instance_type =  lookup(var.instance_type, terraform.workspace, t2.micro)# this is when a variable has 3 value , as u change workspace it will automaticall retrieve e value for that workspace

  tags = {
    Name = var.tags
  }
}