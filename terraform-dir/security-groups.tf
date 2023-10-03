resource "aws_security_group" "weblb_sg" {
  name   = "weblb_sg"
  vpc_id = aws_vpc.demo_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.web_sg.id]
  }
}

resource "aws_security_group" "applb_sg" {
  name   = "applb_sg"
  vpc_id = aws_vpc.demo_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    //security_groups = [aws_security_group.web_sg.id]
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.app_sg.id]
  }
}

resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = aws_vpc.demo_vpc.id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.weblb_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = [var.my_ip]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.applb_sg.id]
    //cidr_blocks       = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name   = "app_sg"
  vpc_id = aws_vpc.demo_vpc.id

  ingress {
    from_port       = 7000
    to_port         = 7000
    protocol        = "tcp"
    security_groups = [aws_security_group.applb_sg.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    //security_groups = [aws_security_group.db_sg.id]
    cidr_blocks       = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name   = "db_sg"
  vpc_id = aws_vpc.demo_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
}
