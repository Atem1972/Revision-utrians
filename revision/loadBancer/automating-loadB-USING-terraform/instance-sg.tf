# Create a security group
resource "aws_security_group" "web-server" {
  name        = "allow_http_access"
  description = "allow http traffic from alb"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "traffic from alb"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]

  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "web-server-sg"
  }
}
