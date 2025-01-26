resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.vp1.id
  description = "Allow MySQL from web server"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"] # Limit access to the web server subnet
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "db-security-group"
  }
}