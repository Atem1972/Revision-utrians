#data for amazon linux

data "aws_ami" "amazon-3" {
    most_recent = true
  
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
    owners = ["amazon"]
  }


resource "aws_instance" "dnk3" {
    ami = data.aws_ami.amazon-2.id  #or"ami-0eaf7c3456e7b5b68" # to get this go to aws try to lounch instance copy
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private1.id 
   # security_groups = ["revision"] #existing security group in aws (ooR)
    security_groups = [aws_security_group.db_sg.id]
    depends_on = [aws_security_group.db_sg]
    #key_name = "valery" #copy from available key in aws OR
    key_name = aws_key_pair.aws_key.key_name
    user_data = file("DB.sh")
      #creating the sise of HD U want if u dont put it it will creat default one ie 8g
    root_block_device {
    volume_size = 30  
    volume_type = "gp2"  
  }

   tags = {
    Name = "db-server"
  }
  
}