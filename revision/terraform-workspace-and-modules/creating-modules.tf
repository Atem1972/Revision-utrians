variable "region" {
  
}

variable "ami" {
  
}

variable "instance_type" {
  description = "value"
  type = map(string)
  default = {
  "dev" = "t2.micro"
  "qa"  = "t2.medium"
  "pro" = "t2.xlarg"
  }
}

variable "tags" {
  
}


module "ec2-instance" {
  source = "./ec2-instance"
  region = var.region
  ami = var.ami
  instance_type = var.instance_type
  tags = var.tags

}