# Load Balancer
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lamp.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Name = "web-lb"
  }
  depends_on = [aws_security_group.lamp]
}

# Load Balancer Target Group
resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vp1.id

  tags = {
    Name = "web-target-group"
  }
}

# Load Balancer Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Attach Instances to Target Group
resource "aws_lb_target_group_attachment" "web_attachments" {
  for_each = {
    "dnk"  = aws_instance.dnk.id,
    "dnk1" = aws_instance.dnk1.id
  }

  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = each.value
  port             = 80
}

# Private Route Table (for private subnets, routing traffic to a NAT Gateway)
resource "aws_route_table" "prit_route1" {
  vpc_id = aws_vpc.vp1.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat3.id  # NAT Gateway
  }
}
