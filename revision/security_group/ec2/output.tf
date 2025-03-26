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