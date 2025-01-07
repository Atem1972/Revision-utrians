provider "aws" {
  region = "us-east-1"  # Update to your preferred region
}

# VPC Setup
resource "aws_vpc" "main" {
  cidr_block = "172.0.0.0/16"
}

#internet gatway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main IGW"
  }
}


# # Public Subnets
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

#route table fo rpublic
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public.id
}

















# Private Subnets
resource "aws_subnet" "private_sub_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.0.3.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_sub_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.0.4.0/24"
  availability_zone = "us-east-1b"
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

resource "aws_db_instance" "mysql" {
  identifier        = "wordpress-mysql"
  engine            = "mysql"
  engine_version    = "5.7.44"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
   skip_final_snapshot = true
  db_name           = "wordpress"
  username          = "valery"
  password          = "School123!"  # Ensure no extra spaces or newlines
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.lamp_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main.name

  tags = {
    Name = "WordPress MySQL"
  }
}



resource "aws_db_subnet_group" "main" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_sub_a.id,
    aws_subnet.private_sub_b.id
  ]
    

  tags = {
    Name = "WordPress DB Subnet Group"
  }
}

#data for amazon linux

data "aws_ami" "amazon-2" {
    most_recent = true
  
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
    owners = ["amazon"]
  }




# EC2 Instance for WordPress
resource "aws_instance" "lamp" {
  ami           = data.aws_ami.amazon-2.id # Amazon Linux 2 AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_a.id
  vpc_security_group_ids = [aws_security_group.lamp_sg.id]
  key_name      =  aws_key_pair.aws_key.key_name # Ensure you have this key in your AWS account
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum install httpd mariadb-server mariadb-server wget -y
              systemctl enable httpd
              systemctl start httpd
              systemctl start mariadb
              systemctl enable mariadb
              create user oracle@localhost identified by 'school1';
              grant all privileges on webserver.* to oracle@localhost identified by 'school1';
              flush privileges; 
              exit
              systemctl restart httpd
              sudo wget https://wordpress.org/latest.tar.gz
              sudo tar -xzvf latest.tar.gz -C /var/www/html/
             sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php 
             chown -R apache:apache /var/www/html/* 
             systemctl restart httpd


              # Configure WordPress (replace with your MySQL RDS info)
              cp wp-config-sample.php wp-config.php
              sed -i 's/database_name_here/wordpress/' wp-config.php
              sed -i 's/username_here/valery/' wp-config.php
              sed -i 's/password_here/school/' wp-config.php
              sed -i 's/localhost/${aws_db_instance.mysql.endpoint}/' wp-config.php
              EOF

  tags = {
    Name = "WordPress-LAMP"
  }
}

# Load Balancer
resource "aws_lb" "wordpress_lb" {
  name               = "wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lamp_sg.id]
  subnets            = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id,
  ]

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
  name = "dev-guro.info"  # Replace with your domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.id
  name    = "www1"
  type    = "A"
  alias {
    name                   = aws_lb.wordpress_lb.dns_name
    zone_id                = aws_lb.wordpress_lb.zone_id
    evaluate_target_health = true
  }
}

