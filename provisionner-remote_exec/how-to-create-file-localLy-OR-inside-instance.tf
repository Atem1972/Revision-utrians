provider "aws" {
  region = "us-east-1"
  alias = "us1"
}

provider "aws" {
  region = "us-east-2"
  alias = "us1"
}

provider "aws" {
  region = "us-west-1"
  alias = "us3"
}

resource "aws_instance" "web" {
  provider = aws.us1 # metargument
  instance_type = t2_micro
  key_name = aws_key_pair.my-key.key_name  # we could have still put only the key name here and write  DEPEND_on = aws_key_pair.jfgh.
  ami = "ami-0c947w984498"


  # putting provissioner under instance resource block
  # METHOD 1
provisioner "local-exec" { # this will only be executed loacaly on my laptop an not online
  command = "echo hello"
  
}
provisioner "local-exec" {
  command = "sleep 4"
}
provisioner "local-exec" {
  command = "touch provisioner.txt"
}

  
    
    
    # this will be executed inside our instance
    provisioner "remote-exec" {
      connection {
        type = "ssh"     # this block is simply telling which instance ip u need to execute in it and ssh most be open
        host =   self.public_ip    # for u to use self.public_ip , the provisioner most be within this resource block
        private_key = "<put ur key name here>"
      }
      inline = [ 
        "sudo yum update -y",
        "sudo install httpd",
        "systemctl enable httpd",
        "systemctl start httpd", # u can add many command 
        "touch had.txt",
        "mkdir config"

      ]
}
     
     
     
     # how to copy a file we created locally using LOCAL EXEC TO OUR INSTANCE ONLINE
      provisioner "file" {
        source = "provisioner.txt" # this file was created locally but will are copying it to our instance
        destination = "/home/ec2-user/prvisioner.txt"
      }
}




###### we can also do provisioner in another way ie create a resource and put it under rather than mixing it up with instance resource
#### METHOD 2




resource "null" "n1" {  # resource null means empty container, i dont want to create any resource in aws but it is just for my practise
provisioner "local-exec" { # this will only be executed loacaly on my laptop an not online
  command = "echo hello"
  
}
provisioner "local-exec" { # all of this will run just on our local laptop 
  command = "sleep 4"
}
provisioner "local-exec" {
  command = "touch provisioner.txt"
}
 
# this will be executed inside our instance
    provisioner "remote-exec" {
      inline = [ 
        "sudo yum update -y",
        "sudo install httpd",
        "systemctl enable httpd",
        "systemctl start httpd", # u can add many command 
        "touch had.txt",
        "mkdir config"

      ]
}
      connection { # this keypair part of the code is needed any time we want to create REMOTE-EXEC
        type = "ssh"     # this block is simply telling which instance ip u need to execute in it and ssh most be open
        port = 22
        user = "ec2-user"
        host = aws_instance.web.public_ip #  or self.public_ip    # for u to use self.public_ip  
        private_key = file("local_file.ssh_key.filename") ## this is from our keypair resource
      }


     
      # how to copy a file we created locally using LOCAL EXEC TO OUR INSTANCE ONLINE
      provisioner "file" {
        source = "provisioner.txt" # this file was created locally but will are copying it to our instance
        destination = "/home/ec2-user/prvisioner.txt"
      }

depends_on = [ aws_instance.web,local_file.ssh_key ]
}
