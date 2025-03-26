#data for amazon linux

data "aws_ami" "amazon-2" {
    most_recent = true
  
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
    owners = ["amazon"]
  }


resource "aws_instance" "dnk" {
    count =length(var.subnet_cidr_private) # create me instance reference the number of instance i want from this variable
    ami = var.aws_ami  #or"ami-0eaf7c3456e7b5b68" # to get this go to aws try to lounch instance copy
    instance_type = var.instance_type
    subnet_id =  element(aws_subnet.private.*.id, count.index)  #retrieve
   
    vpc_security_group_ids =  [aws_security_group.web-server.id]
    
    key_name = var.key_name
    user_data = file("install.sh")
      #creating the sise of HD U want if u dont put it it will creat default one ie 8g
    root_block_device {
    volume_size = 30  
    volume_type = "gp2"  
  }
  
}