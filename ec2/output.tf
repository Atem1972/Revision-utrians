output "pu-id" {
    value = aws_instance.dnk.public_ip  #after dnk is attribute
  
}
 output "instance-type" {
    value = aws_instance.dnk.instance_type
   
 }
 output "key_name" {
    value = aws_instance.dnk.key_name
   
 }
 output "az" {
    value = aws_instance.dnk.availability_zone
   
 }

 output "ssh-command" {
  value = "ssh -i ${aws_key_pair.aws_key.key_name}.pem ec2-user@${aws_instance.dnk.public_dns}"
}