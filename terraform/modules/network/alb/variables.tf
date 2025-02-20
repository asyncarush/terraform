variable "load_balancer_configs" {
  description = "Configuration for multiple load balancers"
  type = map(object({
    name        = string
    internal    = bool
    environment = string
  }))
  default = {
    "lb1" = {
      name        = "custom-resolver-alb-dev"
      internal    = false
      environment = "dev"
    },
    "lb2" = {
      name        = "wpp-server-alb-dev"
      internal    = false
      environment = "dev"
    },
    "lb3" = {
      name        = "opensearch-rag-services-alb"
      internal    = false
      environment = "dev"
    },
    "lb4" = {
      name        = "flowise-public-lb"
      internal    = false
      environment = "dev"
    }
  }
}

variable "vpc_id" {
  description = "VPC ID for the load balancers"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
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
