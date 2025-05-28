project-root/
│
├── module-part2/               # Reusable module folder
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── dev/                        # Dev environment
│   └── main.tf
│
└── prod/                       # Prod environment
    └── main.tf














provider "aws"{
    region = "us-east-1"
}


resource "aws_s3_bucket" "b1" {
  bucket = "sk-terraform35"

}

#EXecute it by run terraform apply



###how to reuse this code ie than to keep creating it to different people all the time, we can just write them a module an give them just what the can be putting their value lik the name of the s3 bucket and called the code from us
# example

# lets create variable.terraform 
   variable "region_name" {
     description = "rgion where u want the bucket"
     default = "us-east-1"
     type = "string"
   }

   variable "bucket_name1" {
     description = "bucket_na,e"
     default = "jkkkd"
     type = "string"
   }


## lets creat main.tf
   provider "aws"{
    region = var.region_name
}


resource "aws_s3_bucket" "b1" {
  bucket = var.bucket_name1

}


## let great ouput
output "bucket_name" {
  value = aws_s3_bucket.b1.bucket
}


##### here now dev enviromment is calling my code
## create a folder call dev  and a file call main.tf
   provider "aws"{
    region =  "us-east"
}


module "s3"{


    source = "../../module-part2"
    bucket_name1 = "my-bucket"
    region_name = "us-west-2"
}



## for production
# create a folder call prod  and create a file called  main.terraform 

   provider "aws"{
    region =  "us-east"
}


module "s3"{


    source = "../../module-part2"
    bucket_name1 = "my-reall-name"
    region_name = "us-north-2"
}