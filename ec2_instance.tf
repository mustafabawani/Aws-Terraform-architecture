data "aws_ami" "windows" {
    most_recent = true
  
    filter {
      name   = "description"
      values = ["Microsoft Windows Server 2012 R2 RTM 64-bit Locale English AMI provided by Amazon"]
    }
  
    filter {
      name   = "root-device-type"
      values = ["ebs"]
    }
  
    owners = ["801119661308"] # Canonical
  }

  resource "aws_security_group" "instance" {
    name = "terraform_example_instance"
    vpc_id = aws_vpc.projectVpc.id
  
    ingress {
      from_port   = 80
      to_port     = 80
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
  

resource "aws_instance" "template_instance" {
  ami           = "${data.aws_ami.windows.id}"
  instance_type = "t2.micro"
  key_name      = "project_key"
  subnet_id     = aws_subnet.public_subnet1_AZa.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "template-instance"
  }
  user_data= <<EOF
    <powershell>
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    </powershell>
  EOF

}


resource "aws_ami_from_instance" "template_instance_ami" {
  name = "template-instance-ami"
  source_instance_id = aws_instance.template_instance.id
}