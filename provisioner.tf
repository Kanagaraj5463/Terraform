provider "aws" {
  region = "ap-south-1"
  access_key = "------------------------------fill the key. here.   --------------------------------------"
  secret_key = "------------------------------fill the key.  here. ... --------------------------------------"
}
resource "aws_instance" "tfvm" {
  count = 2
  ami = "ami-0f1fb91a596abf28d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.websg.id ]
  user_data = <<-EOF
                #!/bin/bash
                echo "I am ROCK" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
      Name = "Web-app"
    }
}
resource "aws_security_group" "websg" {
  name = "web-sg01"
  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
