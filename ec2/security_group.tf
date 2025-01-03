# creating security group
resource "aws_security_group" "ec2" {
  name = "web-sg"
  vpc_id = aws_vpc.vp1.id
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
  depends_on = [ aws_vpc.vp1 ]
}