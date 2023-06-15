resource "aws_subnet" "private_subnet1_AZa" {
  vpc_id     = aws_vpc.projectVpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-1-AZa"
  }
}

resource "aws_subnet" "private_subnet2_AZb" {
  vpc_id     = aws_vpc.projectVpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2-AZb"
  }
}

resource "aws_subnet" "private_subnet3_AZb" {
  vpc_id     = aws_vpc.projectVpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-3-AZb"
  }
}
