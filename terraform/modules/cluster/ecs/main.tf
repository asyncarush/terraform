# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "application-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "Main ECS Cluster"
  }
}



# Task Definition Resources
resource "aws_ecs_task_definition" "tasks" {
  for_each = var.task_definitions

  family                   = each.value.family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  execution_role_arn       = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  task_role_arn            = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

  container_definitions = jsonencode(each.value.container_definitions)
}

# ECS Services
resource "aws_ecs_service" "services" {
  for_each = var.task_definitions

  name            = "${each.value.family}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.tasks[each.key].arn
  launch_type     = "FARGATE"
  desired_count   = 2  # Number of task instances

  network_configuration {
    subnets          = var.private_subnet_ids
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  # Optional: Load Balancer configuration
  # load_balancer {
  #   target_group_arn = aws_lb_target_group.example.arn
  #   container_name   = each.value.container_name
  #   container_port   = each.value.port_mappings[0].containerPort
  # }

  tags = {
    Name = "${each.value.family}-service"
  }
}

# Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-services-sg"
  description = "Security group for ECS services"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    from_port   = 3000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ECS Services Security Group"
  }
}