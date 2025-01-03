terraform {
  backend "s3" {
   bucket = "HJHFSJFH" # here we need to go to aws create s3 bucket and bring the in the space of bucket
   key = "dev/terraform.tfstate" #path of our file
   region = "us-east-1"
   dynamodb_table = "locktable" # go to aws creat the table copy the name and bring here
   encrypt = true
  }
}




#####  How to creat s3 bucket and  dynamodb table in aws
# search for s3, creat s3 and it most have a unique name in the whole world
#block public accees, ACL Didable, bucket versioning enable, encrytion type SSE-S3, BUCKET KEY ENABLE
#CREATE BUCKET


#### DYNAMODB Table creation in aws
# go to dynamo
# scrow down click on table and create
#file the space, name locktable,  passion key exactly here LockID, THEN create table