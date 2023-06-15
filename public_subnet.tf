resource "aws_subnet" "public_subnet1_AZa" {
  vpc_id     = aws_vpc.projectVpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-1-AZa"
  }
}

resource "aws_subnet" "public_subnet2_AZb" {
  vpc_id     = aws_vpc.projectVpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-2-AZb"
  }
}
