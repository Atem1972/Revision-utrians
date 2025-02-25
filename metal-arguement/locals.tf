# locals variable most be declear in the same file wit the resource u want to call


locals {
  env = "dev"
}

locals {
  location = "us-east-1"
}


output "gh" {
  value = local.env
}


provider "aws" {
  region = local.location
}