# create a vpc
resource "aws_vpc" "this" {
  cidr_block = "10.20.20.0/26"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "Application-lb"
  }
}

# create a subnet
resource "aws_subnet" "private" {
  count             = length(var.subnet_cidr_private)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr_private[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    "Name" = "Application-lb-private"
  }
}

# create a route table
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-lb-route-table"
  }
}

# create a route table association
resource "aws_route_table_association" "private" {
  count          = length(var.subnet_cidr_private)  # this mean go to that variable count the total number of element in the value and creat me route-table-association of that same number
  subnet_id      = element(aws_subnet.private.*.id, count.index) # it will go to that particular variable retrieve the element(value) and bring it here . and .*.id means add .id at the end 
  route_table_id = aws_route_table.this-rt.id                     #count.index means differential the two table name by add 0 to the first route-table-associate name and 1 to the second
}

# create an internet gateway
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-lb-gateway"
  }
}

# create an internet route
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}

