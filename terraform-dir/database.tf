resource "aws_db_subnet_group" "rds-subnet-gp" {
  name       = "education"
  subnet_ids = ["${aws_subnet.db_subnetA.id}", "${aws_subnet.db_subnetB.id}"]

  tags = {
    Name = "dev"
  }
}

resource "aws_db_instance" "demo-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet-gp.name
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]

  multi_az = var.multi_az

  # To ensure the primary instance is in us-east-1a, specify its availability zone
  availability_zone = var.az_1

  backup_retention_period = 7
  skip_final_snapshot     = true

  tags = {
    Environment = "dev"
  }
}