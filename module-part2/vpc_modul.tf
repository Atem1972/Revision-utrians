
#  Directory Structure
project-root/
│
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── dev/
│   └── main.tf
├── qa/
│   └── main.tf
└── prod/
    └── main.tf



    ##  modules/vpc/main.tf
    # Create VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env_name}-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name}-public-${count.index + 1}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.env_name}-igw"
  }
}

# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.env_name}-public-rt"
  }
}

# Associate each public subnet with the route table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public[*].id)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}



#### variables.tf     
 
 variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the public subnets"
  type        = list(string)
}

variable "env_name" {
  description = "Environment name (e.g., dev, prod, qa)"
  type        = string
}




####### outputs.tf
 output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "route_table_id" {
  value = aws_route_table.public.id
}





######## folder called dev/main.tf (Example Usage)
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "../modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  env_name           = "dev"
}







