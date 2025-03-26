provider "aws" {
  region = "us-west-2"  # Update to your preferred region
}

# VPC Setup
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Subnet for public resources (EC2, Load Balancer)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

# Subnet for private resources (RDS)
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2a"
}

# Security Group Setup
resource "aws_security_group" "lamp_sg" {
  name        = "lamp-sg"
  description = "Allow inbound HTTP, HTTPS, and SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS MySQL Database Setup
resource "aws_rds_instance" "mysql" {
  identifier        = "wordpress-mysql"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "wordpress"
  username          = "valery"
  password          = "school"
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.lamp_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main.name

  tags = {
    Name = "WordPress MySQL"
  }
}

# Database Subnet Group (for RDS)
resource "aws_db_subnet_group" "main" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id]

  tags = {
    Name = "WordPress DB Subnet Group"
  }
}

# EC2 Instance for WordPress
resource "aws_instance" "lamp" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.lamp_sg.id]
  key_name      = "my-key"  # Ensure you have this key in your AWS account
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              # Update and install Apache, MySQL client, and PHP
              yum update -y
              yum install -y httpd mysql56-server php php-mysqlnd php-fpm
              systemctl enable httpd
              systemctl start httpd
              systemctl enable php-fpm
              systemctl start php-fpm

              # Install WordPress
              cd /var/www/html
              wget https://wordpress.org/latest.tar.gz
              tar -xvzf latest.tar.gz
              cp -r wordpress/* .
              chown -R apache:apache /var/www/html

              # Configure WordPress (replace with your MySQL RDS info)
              cp wp-config-sample.php wp-config.php
              sed -i 's/database_name_here/wordpress/' wp-config.php
              sed -i 's/username_here/valery/' wp-config.php
              sed -i 's/password_here/school/' wp-config.php
              sed -i 's/localhost/${aws_rds_instance.mysql.endpoint}/' wp-config.php
              EOF

  tags = {
    Name = "WordPress-LAMP"
  }
}

# Load Balancer Setup
resource "aws_lb" "wordpress_lb" {
  name               = "wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.lamp_sg.id]
  subnets            = [aws_subnet.public_subnet.id]

  enable_deletion_protection = false
}

# Load Balancer Target Group
resource "aws_lb_target_group" "wordpress_target_group" {
  name     = "wordpress-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Route 53 Setup (Optional)
resource "aws_route53_zone" "main" {
  name = "example.com"  # Replace with your domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.id
  name    = "www"
  type    = "A"
  alias {
    name                   = aws_lb.wordpress_lb.dns_name
    zone_id                = aws_lb.wordpress_lb.zone_id
    evaluate_target_health = true
  }
}

