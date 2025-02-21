resource "aws_security_group" "lb_sg" {
  name        = "load-balancer-sg"
  description = "Security group for load balancers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load-balancer-security-group"
  }
}

resource "aws_lb" "load_balancers" {
  for_each = var.load_balancer_configs

  name               = each.value.name
  internal           = each.value.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = each.value.internal ? var.private_subnet_ids : var.public_subnet_ids

  tags = {
    Name        = each.value.name
    Environment = each.value.environment
  }
}