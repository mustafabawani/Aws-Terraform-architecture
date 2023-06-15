
  resource "aws_security_group" "lb_sg" {
    name = "lb_sg"
    vpc_id = aws_vpc.projectVpc.id
  
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

resource "aws_lb" "server_loadbalancer" {
  name               = "server-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet1_AZa.id, aws_subnet.public_subnet2_AZb.id]

  enable_deletion_protection = false

  tags = {
    Name = "server_loadbalancer"
  }
}

resource "aws_lb_listener" "server_loadbalancer" {
  load_balancer_arn = aws_lb.server_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server_loadbalancer.arn
  }
}

resource "aws_lb_target_group" "server_loadbalancer" {
  name     = "asg-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.projectVpc.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_autoscaling_attachment" "ASG_attachment" {
  autoscaling_group_name = aws_autoscaling_group.Server_ASG.id
  lb_target_group_arn   = aws_lb_target_group.server_loadbalancer.arn
}
