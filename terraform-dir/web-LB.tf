resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.weblb_sg.id]

  subnets = [
    aws_subnet.web_subnetA.id,
    aws_subnet.web_subnetB.id
  ]
}

resource "aws_lb_target_group" "webTG" {
  name     = "webTG"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo_vpc.id

  health_check {
    enabled             = true
    port                = 3000
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "webListener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webTG.arn
  }
}