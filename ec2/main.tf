resource "aws_instance" "dnk" {
    ami ="ami-0eaf7c3456e7b5b68" # to get this go to aws try to lounch instance copy
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public1  
   # security_groups = ["revision"] #existing security group in aws (ooR)
    security_groups = [aws_security_group.ec2.name]
    #key_name = "valery" #copy from available key in aws OR
    key_name = aws_key_pair.aws_key.key_name
    user_data = file("install.sh")
  
}