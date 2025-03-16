
# creating ec2
resource "aws_instance" "sg" {
security_groups = [aws_security_group.ec2.name]
  ami ="ami-0eaf7c3456e7b5b68" # to get this go to aws try to lounch instance copy
    instance_type = "t2.micro"
    key_name = "valery" #copy from available key in aws
    user_data = file("install.sh")

  
}

# creating security group
resource "aws_security_group" "ec2" {
  name = "web-sg"
  description = "Allow ssh and http"

  ingress ={
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # this simply means from everywhere
  }

  ingress{
       description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # this simply means from everywhere
  }

   ingress{
       description = "allow custom"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # this simply means from everywhere
  }
 
  egress {  # outbound trafic
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]   # this simply means from everywhere
  }

  tags = {
    env = "Dev"
  }
}