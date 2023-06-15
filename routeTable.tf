resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.projectVpc.id

  tags = {
    Name = "project-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.projectVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.public_subnet1_AZa.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2" {
  subnet_id      = aws_subnet.public_subnet2_AZb.id
  route_table_id = aws_route_table.public_route_table.id
}



resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.projectVpc.id
  
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat.id
    }
  
    tags = {
      Name = "private-route-table"
    }
  }
  
  resource "aws_route_table_association" "private_subnet1" {
    subnet_id      = aws_subnet.private_subnet1_AZa.id
    route_table_id = aws_route_table.private_route_table.id
  }
  
  resource "aws_route_table_association" "private_subnet2" {
    subnet_id      = aws_subnet.private_subnet2_AZb.id
    route_table_id = aws_route_table.private_route_table.id
  }
  
  resource "aws_route_table_association" "private_subnet3" {
    subnet_id      = aws_subnet.private_subnet3_AZb.id
    route_table_id = aws_route_table.private_route_table.id
  }
  