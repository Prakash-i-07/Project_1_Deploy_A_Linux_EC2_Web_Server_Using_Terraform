terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.0"
   }
 }
}
provider "aws" {
 region = "us-east-1"
}
data "aws_ami" "ubuntu" {
 most_recent = true
 owners      = ["099720109477"]
 filter {
   name   = "name"
   values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
 }
}
resource "aws_default_vpc" "default" {
 tags = {
   Name = "project1-default-vpc"
 }
}
data "aws_subnets" "default_subnets" {
 filter {
   name   = "vpc-id"
   values = [aws_default_vpc.default.id]
 }
}
resource "aws_security_group" "web_sg" {
 name        = "project1-web-sg"
 description = "Allow SSH and HTTP"
 vpc_id      = aws_default_vpc.default.id
 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
   Name = "project1-web-sg"
 }
}
resource "aws_instance" "web_server" {
 ami                         = data.aws_ami.ubuntu.id
 instance_type               = "t3.micro"
 subnet_id                   = data.aws_subnets.default_subnets.ids[0]
 vpc_security_group_ids      = [aws_security_group.web_sg.id]
 associate_public_ip_address = true
 user_data = "#!/bin/bash\napt-get update -y\napt-get install -y nginx\necho '<h1>Deployed via Terraform on AWS EC2</h1>' > /var/www/html/index.html\nsystemctl enable nginx\nsystemctl restart nginx\n"
 tags = {
   Name = "project1-web-server"
 }
}
output "web_server_public_ip" {
 value = aws_instance.web_server.public_ip
}
