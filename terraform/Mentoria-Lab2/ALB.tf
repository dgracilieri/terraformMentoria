#la capa de balanceo de carga

resource "aws_lb" "lb_carancas" {
  name               = "carancas-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.publicsgr.id]
  subnets            = aws_subnet.subnets[*].id  

  enable_deletion_protection = false

tags = merge({Name = join("-",tolist(["LoadBalancer", var.marca, var.environment]))},local.tags)
}

resource "aws_lb_target_group" "tg-instances-carancas" {
  name        = "tf-carancas-instances-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc01.id
  health_check {
    path                = "/"
  }

  tags = merge({Name = join("-",tolist(["INSTANCES-Target-Group", var.marca, var.environment]))},local.tags)

}

resource "aws_lb_listener" "lb_carancas_80" {
  depends_on = [aws_lb_target_group.tg-instances-carancas]
  load_balancer_arn = aws_lb.lb_carancas.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg-instances-carancas.arn
    type             = "forward"

  }
}
