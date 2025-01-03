## creating vpc
## creating vpc
resource "aws_vpc" "vp1" { # anything bellow this resouce is an agurment
  cidr_block = "172.120.0.0/16" # this shld alway be given to you and each vpc has unique
  instance_tenancy = "default"
  tags ={
    Name = "utc-app"
    Team ="wdp"
    env = "dev"
  }
}


## creating internet gatway, this allow trafic from the internet to flow in our infrastructure in the vpc and only for infrastructure with public subnet will receive it
## creating internet gatway,  without the internetgat way our vpc is a private
resource "aws_internet_gateway" "gtw" {
    vpc_id = aws_vpc.vp1.id 
}


### public subnet1
resource "aws_subnet" "public1" {
  availability_zone = "us-east-1a"
  cidr_block = "172.120.1.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.vp1.id
  tags = {
    Name = "utc-public-subnet-1a"
  }
}


### public subnet2
resource "aws_subnet" "public2" {
  availability_zone = "us-east-1b"
  cidr_block = "172.120.2.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.vp1.id
    tags = {
    Name = "utc-public-subnet-1b"
  }
}



### private subnet1
resource "aws_subnet" "private1" {
  availability_zone = "us-east-1a"
  cidr_block = "172.120.3.0/24"
  vpc_id = aws_vpc.vp1.id
      tags = {
    Name = "utc-private-subnet-1b"
  }
}

### private subnet2
resource "aws_subnet" "private2" {
  availability_zone = "us-east-1b"
  cidr_block = "172.120.4.0/24"
  vpc_id = aws_vpc.vp1.id
      tags = {
    Name = "utc-private-subnet-1b"
  }
}


### Nat gateway, this will help infrastructure on private subnet to have access to the internet to download
## creating elastic ip 
resource "aws_eip" "eip" {
  
}
### Nat gateway, this will help infrastructure on private subnet to have access to the internet to download
resource "aws_nat_gateway" "nat1" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public1.id
  
}






###creating route table
#public route table
resource "aws_route_table" "pub-route1" {
  vpc_id = aws_vpc.vp1.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gt.id
  }
}


### creating private route table
resource "aws_route_table" "pri-route1" {
  vpc_id = aws_vpc.vp1.id
  route ={
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id  #internetgatway id
  }
}



### Route and public1-subnet association
resource "aws_route_table_association" "association-pub1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.pub-route1
  
}

### Route and public2-subnet association
resource "aws_route_table_association" "association-pub2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.pub-route1
  
}






### Route and private1-subnet association
resource "aws_route_table_association" "association-privat2" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.pri-route1.id
  
}

### Route and public2-subnet association
resource "aws_route_table_association" "association-private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.pri-route1.id
  
}