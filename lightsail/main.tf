
#creating group
resource "aws_iam_group" "developers" {
  name = "dev-team"
  
}
#creating user
resource "aws_iam_user" "loo" {
  name = "kum"
  }

#creating lightsail
resource "aws_lightsail_instance" "lg" {
  name              = "gamkang"
  availability_zone = "us-east-1b"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_3_0"
  key_pair_name = "week2"
  user_data      = file("install.sh")
  tags ={
    team = "Devops"
    evv = "dev"
    created_by = "Terraform"
  }
}
