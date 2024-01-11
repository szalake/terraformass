resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "Allow TLS inbound traffic"
  vpc_id      =aws_vpc.VPC.id

  ingress {
    description      = "inbound rule from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.VPC.cidr_block]
	ipv6_cidr_blocks = ["::/0"]
 //   ipv6_cidr_blocks = [aws_vpc.VPC.ipv6_cidr_block]
  }
  
   ingress {
    description      = "inbound rule from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.VPC.cidr_block]
	ipv6_cidr_blocks = ["::/0"]
 //   ipv6_cidr_blocks = [aws_vpc.VPC.ipv6_cidr_block]
  }
  
  ingress {
    description      = "inbound rule from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.VPC.cidr_block]
	ipv6_cidr_blocks = ["::/0"]
 //   ipv6_cidr_blocks = [aws_vpc.VPC.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "security_group"
  }
}
