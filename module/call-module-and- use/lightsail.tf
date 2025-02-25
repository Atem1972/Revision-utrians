module "lightsail" {
  source = "../module" # put the name of the folder where the variabl is found
  # bellow is the variable that has been declear on the above folder , now we are only putting our own value
  resouce_name = "dev1" 
  bundle_id = "t2_micro"  # all this value can be change when calling it
  blue_print = "amazon_linux_2"
  avialability_zone = "us-east-1"
  instance_name = "udt"
  key-name = "opera"
   env = "dev"
   Team = "qa"
   aws_iam_user = "valery"
   aws_iam_group = "sg_team"


}