resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.dnk.availability_zone
  size = 50
  
  
  tags ={
    Name = "devops"
  }
}