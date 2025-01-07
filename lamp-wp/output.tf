# Output the EC2 instance public IP
output "ec2_instance_public_ip" {
  value = aws_instance.lamp.public_ip
  description = "Public IP address of the EC2 instance."
}

# Output the EC2 instance public DNS
output "ec2_instance_public_dns" {
  value = aws_instance.lamp.public_dns
  description = "Public DNS name of the EC2 instance."
}

# Output the Load Balancer DNS name
output "load_balancer_dns" {
  value = aws_lb.wordpress_lb.dns_name
  description = "DNS name of the Application Load Balancer."
}
