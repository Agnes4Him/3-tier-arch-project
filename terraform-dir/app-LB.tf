resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.applb_sg.id]

  subnets = [
    aws_subnet.app_subnetA.id,
    aws_subnet.app_subnetB.id
  ]
}

resource "aws_lb_target_group" "appTG" {
  name     = "appTG"
  port     = 7000
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo_vpc.id

  health_check {
    enabled             = true
    port                = 7000
    interval            = 240
    protocol            = "HTTP"
    path                = "/health"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "appListener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appTG.arn
  }
}