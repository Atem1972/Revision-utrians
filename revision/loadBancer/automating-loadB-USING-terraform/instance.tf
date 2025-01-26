# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# launch 2 EC2 instances and install apache 
resource "aws_instance" "web-server" {
  count                  = length(var.subnet_cidr_private)  # this mean go to that variable count the total number of element in the value and creat me instance of that same number 
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.amazon_linux_2.id
  vpc_security_group_ids = [aws_security_group.web-server.id]
  subnet_id              = element(aws_subnet.private.*.id, count.index)  #The element() function retrieves an item from a list in a particular variable. it means go to this particular variable copy all the things u see the bring here.
  user_data              = file("install_httpd.sh")                       # and the .*.id mean add .id to it  and the count.index means copy the first subnet element in webserver1 and the second put it in webserver2 
  associate_public_ip_address = true
  tags = {
    Name = "web-server-${count.index + 1}" # simply numbering the instance ie web-server1 and webserver2   but is it was just ${count.index} then it will start e numbering from 0-1
  }
}
