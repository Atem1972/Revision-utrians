## Creating VPC
resource "aws_vpc" "vp1" {
  cidr_block = "172.120.0.0/16"  # this should always be given to you and each VPC has a unique CIDR block
  instance_tenancy = "default"
  tags = {
    Name = "utc-app"
    Team = "wdp"
    env  = "dev"
  }
}

## Creating Internet Gateway (this allows traffic from the internet to flow into the VPC and only for infrastructure with public subnets)
resource "aws_internet_gateway" "gtw" {
  vpc_id = aws_vpc.vp1.id
}

### Public Subnet 1
resource "aws_subnet" "public1" {
  availability_zone = "us-east-1a"
  cidr_block = "172.120.1.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.vp1.id
  tags = {
    Name = "utc-public-subnet-1a"
  }
}

### Public Subnet 2
resource "aws_subnet" "public2" {
  availability_zone = "us-east-1b"
  cidr_block = "172.120.2.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.vp1.id
  tags = {
    Name = "utc-public-subnet-1b"
  }
}

### Private Subnet 1
resource "aws_subnet" "private1" {
  availability_zone = "us-east-1a"
  cidr_block = "172.120.3.0/24"
  vpc_id = aws_vpc.vp1.id
  tags = {
    Name = "utc-private-subnet-1a"
  }
}

### Private Subnet 2
resource "aws_subnet" "private2" {
  availability_zone = "us-east-1b"
  cidr_block = "172.120.4.0/24"
  vpc_id = aws_vpc.vp1.id
  tags = {
    Name = "utc-private-subnet-1b"
  }
}

### Elastic IP (for the NAT Gateway)
resource "aws_eip" "eip" {
  vpc = true
}

### NAT Gateway (allows infrastructure on private subnets to access the internet for updates/downloads)
resource "aws_nat_gateway" "nat3" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public1.id
}

# Public Route Table
resource "aws_route_table" "pub_route1" {
  vpc_id = aws_vpc.vp1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw.id  # Internet Gateway
  }
}

# Private Route Table
resource "aws_route_table" "pri_route1" {
  vpc_id = aws_vpc.vp1.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat3.id  # NAT Gateway
  }
}

### Route and Public1 Subnet Association
resource "aws_route_table_association" "association_pub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.pub_route1.id
}

### Route and Public2 Subnet Association
resource "aws_route_table_association" "association_pub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.pub_route1.id
}

### Route and Private1 Subnet Association
resource "aws_route_table_association" "association_priv1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.pri_route1.id
}

### Route and Private2 Subnet Association
resource "aws_route_table_association" "association_priv2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.pri_route1.id
}
