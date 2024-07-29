resource "aws_instance" "Ngnix" {
    ami = "ami-0427090fd1714168b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-security_group.id]
    associate_public_ip_address = true

    user_data = <<-EOF
                #!/bin/bash
                sudo yum install nginx -y
                sudo service nginx start
                EOF

    tags = {
      Name = "Nginx-server"
    }

  
}

resource "aws_security_group" "nginx-security_group" {
    vpc_id = aws_vpc.my-vpc.id

    #ingress sg
    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    #egress
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
    Name = "Ngnix-security-group"
  }
}