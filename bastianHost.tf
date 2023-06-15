resource "aws_instance" "bastion" {
  ami           = data.aws_ami.windows.id
  instance_type = "t2.micro"
  key_name      = "project_key"

  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id     = aws_subnet.public_subnet1_AZa.id

  tags = {
    Name = "BastionHost"
  }

}

resource "aws_security_group" "bastion" {
  name   = "terraform_example_bastion"
  vpc_id = aws_vpc.projectVpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress{
      from_port= 3389
      to_port = 3389
      protocol = "tcp"
      cidr_blocks=["0.0.0.0/0"]
    }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
