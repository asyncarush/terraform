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

# Task Definitions
variable "task_definitions" {
  description = "Configuration for different ECS task definitions"
  type = map(object({
    family        = string
    container_name = string
    image         = string
    cpu           = number
    memory        = number
    port_mappings = list(object({
      containerPort = number
      hostPort      = number
      protocol      = string
    }))
  }))
  default = {
    "service1" = {
      family         = "frontend-service"
      container_name = "frontend-container"
      image          = "your-account.dkr.ecr.region.amazonaws.com/frontend:latest"
      cpu            = 256
      memory         = 512
      port_mappings = [{
        containerPort = 3000
        hostPort      = 3000
        protocol      = "tcp"
      }]
    },
    "service2" = {
      family         = "backend-service"
      container_name = "backend-container"
      image          = "your-account.dkr.ecr.region.amazonaws.com/backend:latest"
      cpu            = 512
      memory         = 1024
      port_mappings = [{
        containerPort = 8080
        hostPort      = 8080
        protocol      = "tcp"
      }]
    },
    "service3" = {
      family         = "admin-service"
      container_name = "admin-container"
      image          = "your-account.dkr.ecr.region.amazonaws.com/admin:latest"
      cpu            = 256
      memory         = 512
      port_mappings = [{
        containerPort = 4000
        hostPort      = 4000
        protocol      = "tcp"
      }]
    },
    "service4" = {
      family         = "api-service"
      container_name = "api-container"
      image          = "your-account.dkr.ecr.region.amazonaws.com/api:latest"
      cpu            = 512
      memory         = 1024
      port_mappings = [{
        containerPort = 5000
        hostPort      = 5000
        protocol      = "tcp"
      }]
    }
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
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name  = each.value.container_name
    image = each.value.image
    
    portMappings = each.value.port_mappings
    
    # Add environment variables, log configuration, etc. as needed
    environment = [
      {
        name  = "ENV"
        value = "production"
      }
    ]
    
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/${each.value.family}"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
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

# IAM Roles for ECS
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Role Policies (attach necessary policies)
resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}