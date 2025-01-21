#how can we make terraform to track a resources in that was created out of terrafrom. ie we created an ec2 in aws , as we all know
#terraform can not destroy or have a track of that kind or resouces BUT  the question now is how can we make terraform to have a track of it.
  
import {
  to = aws_instance.web
  id = "<put the id of the instance in aws u wish to import. go to aws and copy"
} # this will give u an error message but just copy the last sentence and run or we can declear the resource

resource "aws_instance" "web" {
  
}