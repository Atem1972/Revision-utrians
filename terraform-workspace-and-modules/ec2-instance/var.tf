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