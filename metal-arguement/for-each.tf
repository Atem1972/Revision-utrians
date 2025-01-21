# how to create 10 users in aws with diffn name 
variable "usernames" {
  type    = list(string)
  default = ["peter", "ako", "john", "ayuk", "jjj"]
}

resource "aws_iam_user" "user" {
  for_each = toset(var.usernames)

  name = each.value # this simply means go to the above variable take the first default name put it here second, third fouth and creat my request
}





variable "instance_type" {
  default = ["ty.micro" ,"t3.small", "nano_3_0", "t2.meduim"]
}
variable "availability_zone" {
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}
resource "aws_instance" "server1" {
  for_each = { for combo in setproduct(var.instance_type, var.availability_zone) : "${combo[0]}_${combo[1]}" => combo }
   # this is when u have so many avariable that u need to use for each but if is just one variable that have for_each
  
  ami               = "ami-0ae8f15ae66fe8cda"
  instance_type     = each.value[0] # First element is the instance type
  availability_zone = each.value[1] # Second element is the availability zone
}  # OR

resource "aws_instance" "na2" {
  for_each = toset(var.availability_zone)
   ami             = "ami-0ae8f15ae66fe8cda"
   availability_zone = each.key
}
resource "aws_instance" "na3" {
  for_each = toset(var.instance_type)
  instance_type = each.key
}