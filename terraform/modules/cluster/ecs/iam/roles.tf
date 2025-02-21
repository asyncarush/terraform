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

# Attach policies to ECS Task Role
resource "aws_iam_role_policy_attachment" "ecs_task_role_efs_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.efs_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_ecr_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_cloudwatch_logs" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_aws_services" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.aws_services_policy.arn
}
