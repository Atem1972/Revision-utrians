data "aws_ami" "amz"{
    most_recent = true

    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm*-x86_64-ebs"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["amazon"] 
}





resource "aws_instance" "web" {
  ami =data.aws_ami.amz
  instance_type = "t2.micro"
 count = 2 # metargument
 depends_on = [ aws_security_group ] # depend on
 tags = {
    Name ="dev-${count.index +1}" # to name the instances differently
 }

}

resource "aws_iam_user" "na1" {
  count = 10
  name = "ayuk-${count.index +1}"
}







output "ip" {
  value = aws_instance.web[1].public_ip_address # to pull both [*]
}