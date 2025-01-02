output "pub_ip" {
  value = aws_lightsail_instance.lg.public_ip_address
}

output "key_name" {
  value = aws_lightsail_instance.lg.key_pair_name
}

output "user_name" {
 value = aws_lightsail_instance.lg.username
  
}

output "name_lightsail" {
    value = aws_lightsail_instance.lg.name
  
}

output "bundle_id" {
  value = aws_lightsail_instance.lg.bundle_id
}

output "blueprint_id" {
  value = aws_lightsail_instance.lg.blueprint_id
}

output "AZ" {
  value = aws_lightsail_instance.lg.availability_zone
}

output "tags" {
  value = aws_lightsail_instance.lg.tags
}