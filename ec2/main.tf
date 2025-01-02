resource "aws_instance" "dnk" {
    ami ="ami-0eaf7c3456e7b5b68" # to get this go to aws try to lounch instance copy
    instance_type = "t2.micro"
    key_name = "valery" #copy from available key in aws
    user_data = file("install.sh")
  
}