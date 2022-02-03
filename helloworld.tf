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

resource "aws_vpc" "vpc_brq" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "VPC_legal"
  }
}

resource "aws_internet_gateway" "gw_brq" {
  vpc_id = aws_vpc.vpc_brq.id
  tags = {
    Name = "Deyverson"
  }
}

resource "aws_route_table" "rotas_brq" {
  vpc_id = aws_vpc.vpc_brq.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_brq.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw_brq.id
  }

  tags = {
    Name = "GustavoGomez"
  }
}

resource "aws_subnet" "subrede_brq" {
   vpc_id     = aws_vpc.vpc_brq.id
   cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1a"
   tags = {
     Name = "RonyRustico"
   }
 }

resource "aws_route_table_association" "associacao" {
  subnet_id      = aws_subnet.subrede_brq.id
  route_table_id = aws_route_table.rotas_brq.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

/*resource "aws_instance" "ola-mundo" {
 ami           = "ami-04505e74c0741db8d"
 instance_type = "t2.micro"
 tags = {
      Name = "Robson"
 }
}*/