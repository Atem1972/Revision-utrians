



# Create a Route 53 Hosted Zone (if not already created)
data "aws_route53_zone" "my_domain" {
  name = "dev-guro.info" # Replace with your domain
}

# Add an A record to point to an EC2 instance's public IP
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.my_domain.zone_id
  name    = "fashion.dev-guro.info" # Replace with your subdomain
  type    = "A"

   alias {
     name = aws_lb.web_lb.dns_name  #calling from lb
     zone_id = aws_lb.web_lb.zone_id # calling from lb
     evaluate_target_health = true
   }


  /*ttl     = 300
  records = [aws_instance.dnk.public_ip,
             aws_instance.dnk1.public_ip ] # Replace with the actual public IP*/
}