
  resource "aws_security_group" "launch_security" {
    name = "launch_security"
    vpc_id = aws_vpc.projectVpc.id
  
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
    }
  
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  

resource "aws_launch_template" "ASG_launch_template" {
  name   = "server_launch_template"
  image_id      = aws_ami_from_instance.template_instance_ami.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.launch_security.id]


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "template-instance"
    }
  }

  key_name = "project_key"
}

resource "aws_autoscaling_group" "Server_ASG" {
    name= "server-asg"
  launch_template {
    id = aws_launch_template.ASG_launch_template.id
    version="$Latest"
  }
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.private_subnet1_AZa.id, aws_subnet.private_subnet2_AZb.id]

  tag {
    key                 = "Name"
    value               = "Server-asg"
    propagate_at_launch = true
  }
}