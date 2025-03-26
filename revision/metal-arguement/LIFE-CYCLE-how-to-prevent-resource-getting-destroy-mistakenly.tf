# how to protect resource getting destroy mistakenly my u or someone else? we use metargument call LIFE CYCLE
# EXAMPLE

resource "aws_instance" "server" {
    ami = "ami-0ojnfgffgffgf"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    key_name = "my_key"
    vpc_security_group_ids = [ yfuiiifiuie ]

    lifecycle {
      prevent_destroy = true
    }
}



# WE WANT to make changes on the ami, this will destroy the instance before bring up a new one , how do we prevent that
# ie instead it shld bring up new first before destroying old  ? USE LIFE CYCLE

resource "aws_instance" "server" {
    ami = "ami-0ojnfgffgffgf" # new ami we want to run apply to change
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    key_name = "my_key"
    vpc_security_group_ids = [ yfuiiifiuie ]

    lifecycle {
      create_before_destroy = true
    }
}