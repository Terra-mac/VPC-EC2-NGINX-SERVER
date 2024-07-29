#create the vpc
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.1.0.0/16"

    tags = {
      Name = "my_vpc"
    }
}

#create the subnet
resource "aws_subnet" "private_subnet" {
    cidr_block = "10.1.1.0/24"
    vpc_id = aws_vpc.my-vpc.id

    tags = {
      Name = "private_subnet"
    }
  
}

#Create the route table
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gateway.id

}
tags = {
  Name = "Route table"
}
}

# create the route table association
resource "aws_route_table_association" "route-asso" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.private_subnet.id
  
}

# create the Internet gateway & attachment to vpc
resource "aws_internet_gateway" "my-gateway" {
    
  tags = {
    Name = "my-gateway"
  }
}

resource "aws_internet_gateway_attachment" "my-gateway-attachment" {
    internet_gateway_id = aws_internet_gateway.my-gateway.id
    vpc_id = aws_vpc.my-vpc.id
  
}