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
resource "aws_key_pair" "gokule" {
  key_name   = "gokule"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2ufU1ZjPzfhaqmSwKhxMXbjatIQzFKAaf62OYeH6yU7n7K91I/oVkg/BqR36r3cRk1DP72Sdo3Gsd0Q6zB6buExCJRuSgHM9UgDHmivwJIOHEXsoD5RSUaiLhDcGLPTiO0BVrZ6hz
qhzsaMgHiS96ewA14r20ECN4PR1cZoV4xxAS6K8XllwRczygz+9i0Coodw4pOQaespxNq9mie/p2QsndS8FAkGFCO8JxhUQdA9S+tNHk+ZA/XPWgHXfqhYglkv2FnMKbumls/FdAx0wEweipAH4tuyh8tmw9Tkpmv4f+vbJeEPcILSsn
VCt8bW8NGsevGzyIvEPckKuCY9mV Gokule"
}
