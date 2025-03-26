#creating lightsail
resource "aws_lightsail_instance" "lg" {
  name              = var.lightsail-name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name = var.key_name
  user_data      = file("install.sh")
  tags ={
    team = var.Team
    evv = var.env
    created_by = "Terraform"
  }
}

resource "aws_iam_user" "ust" {
  name = var.aws_iam_user
}

resource "aws_iam_group" "ust1" {
  name = var.aws_iam_group
}