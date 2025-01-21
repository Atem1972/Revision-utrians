output "key_name" {
  value = var.output_pemfile
}

output "pemfile" {
  value = var.output_pemfile
}

output "public-ip" {
  value = aws_lightsail_instance.lg.public_ip_address
}

output "user_name" {
  value = aws_iam_user.ust.name
}
output "group_name" {
  value = aws_iam_group.ust1.name
}


# when and output is not declear in a module note that if u call that module u would not be able to see output block