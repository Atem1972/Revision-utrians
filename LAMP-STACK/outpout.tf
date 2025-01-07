output "pu1-id" {
    value = aws_instance.dnk.public_ip
}
output "pu-id" {
    value = aws_instance.dnk1.public_ip
}

output "dns_name" {
  value = aws_route53_record.www.name
  
}