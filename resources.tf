resource "aws_instance" "terraformEC2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.security_group.name]
  key_name = "devops_key"
  user_data = <<EOF
  #!/bin/bash
  apt-get update
  apt-get install -y httpd
  service httpd start
  chkconfig httpd on
  echo "Welcome to my Web server...." > /var/www/html/index.html/index
  EOF  
tags = {
   Name = "terraformEC2"
 } 
}

resource "aws_eip" "EIP" {
  instance = aws_instance.web.id
  domain   = "vpc"
}




resource "aws_vpc" "VPC" {
  cidr_block       					= "10.0.0.0/16"
  instance_tenancy 					= "default"
  enable_dns_hostnames			    = true
  assign_generated_ipv6_cidr_block  = true

  tags = {
    Name = "terraformVPC"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "terraformIGW"
  }
}




resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.1.0/24"
  availabilty_zone = "us-east-1a"
  mao_public_ip_on_launch = true

  tags = {
    Name = "terraformPublicSubnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id]

  tags = {
    Name = "terraformPublicRT"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}


resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.1.0/24"
  availabilty_zone = "us-east-1a"
  mao_public_ip_on_launch = false

  tags = {
    Name = "terraformPrivateSubnet"
  }
}
