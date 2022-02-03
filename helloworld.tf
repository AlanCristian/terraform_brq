terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "3.74.0"
   }
 }
}

provider "aws" {
 region     = "us-east-1"
 #access_key = ""
 #secret_key = ""
}

/*resource "aws_instance" "ola-mundo" {
 ami           = "ami-04505e74c0741db8d"
 instance_type = "t2.micro"
}*/