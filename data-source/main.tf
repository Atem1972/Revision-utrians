# what is data source ? referencing something that was not created by terraform and u pull data from it and use in terraform eg id of an instance in aws
# this help u to do evntary on an instance u dont not have access to in aws but withhhhhhh thhis instance id u can pull data from the runing instance


/*01
data "aws_instance" "dt1" {
 instance_id = "i-07e93ed686b6f15bc" #<go to ur aws copy the instance_id of ur run instance put it here> calling

}

 resource "aws_instance" "d1" {
  ami = data.aws_instance.dt1.ami
 instance_type = data.aws_instance.dt1.instance_type
 availability_zone = data.aws_instance.dt1.availability_zone
security_groups = data.aws_instance.dt1.security_groups
 key_name = data.aws_instance.dt1.key_name
  
}
# # u can run and create another instance with the same service
*/ end of this code

02
#how to pull AMI from aws without login in


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # Adjust for desired version
  }                                                                   # we can change to amazon linux, redhat etc

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["AMAZON"] # Canonical's AWS account ID
}


# creating instance that will use the above ami
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
    tags = {
    Name = "UbuntuServer"
  }
}
