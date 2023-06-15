resource "aws_db_subnet_group" "mysql" {
  name       = "mysql"
  subnet_ids = [aws_subnet.private_subnet1_AZa.id, aws_subnet.private_subnet2_AZb.id]

  tags = {
    Name = "My database subnet group"
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = aws_vpc.projectVpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.launch_security.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "mustafa"
  password             = "MUSTAFAdanish"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.mysql.name
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "MySQL RDS instance"
  }
}
