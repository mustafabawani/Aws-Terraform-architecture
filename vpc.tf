resource "aws_vpc" "projectVpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project-vpc"
  }
}
