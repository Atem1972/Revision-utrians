resource "tls_private_key" "ec2_key" {
algorithm = "RSA" # the are other types of algorithm
rsa_bits = 2048
  
}
#this key will be attach to our instance in aws
resource "aws_key_pair" "aws_key" {
  key_name = "terraform-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

#this key will be save locally
resource "local_file" "ssh_key" {
filename = "${aws_key_pair.aws_key.key_name}.pem" # or "terraform.pem" # this will be created on this folder but if we want to download
  #filename = "~/Downloads/terraform.pem
content = tls_private_key.ec2_key.private_key_pem
file_permission = "400"
}

# ssh -i terraform.pem ec2-user@3.2.3.4