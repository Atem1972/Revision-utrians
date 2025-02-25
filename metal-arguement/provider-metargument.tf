provider "aws" {
  region = "us-east-1"
  alias = "us1"
}

provider "aws" {
  region = "us-east-2"
  alias = "us1"
}

provider "aws" {
  region = "us-west-1"
  alias = "us3"
}




resource "aws_instance" "web" {
  provider = aws.us1
  instance_type = t2_micro
  ami = ami-09099
  
}