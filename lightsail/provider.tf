  #terraform block
terraform{ 
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.66.1"
    }
  }
}

#aws block
provider "aws" {
  region = "us-east-1"
}

