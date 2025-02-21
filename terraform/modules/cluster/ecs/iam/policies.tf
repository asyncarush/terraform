# EFS Access Policy
resource "aws_iam_policy" "efs_access_policy" {
  name        = "ecs-efs-limited-access"
  description = "Limited EFS access policy for ECS tasks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets"
        ]
        Resource = [
          "arn:aws:elasticfilesystem:eu-central-1:941128203839:file-system/fs-06ac48d8379275808",  # Flowise EFS
          "arn:aws:elasticfilesystem:eu-central-1:941128203839:file-system/fs-12345678",           # Custom Resolver EFS
          "arn:aws:elasticfilesystem:eu-central-1:941128203839:file-system/fs-87654321"            # WPP Server EFS
        ]
      }
    ]
  })
}

# ECR Pull Policy
resource "aws_iam_policy" "ecr_pull_policy" {
  name        = "ecs-ecr-pull-policy"
  description = "Policy to pull images from specific ECR repositories"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = [
          "arn:aws:ecr:eu-central-1:941128203839:repository/custom-resolver-repo-dev",
          "arn:aws:ecr:eu-central-1:941128203839:repository/flowise",
          "arn:aws:ecr:eu-central-1:941128203839:repository/rag-opensearch",
          "arn:aws:ecr:eu-central-1:941128203839:repository/wpp-server-repo-dev"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      }
    ]
  })
}

# CloudWatch Logs Policy
resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "ecs-cloudwatch-logs-policy"
  description = "Policy to write logs for ECS services"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ]
        Resource = [
          "arn:aws:logs:eu-central-1:941128203839:log-group:/ecs/custom-resolver:*",
          "arn:aws:logs:eu-central-1:941128203839:log-group:/ecs/flowise:*",
          "arn:aws:logs:eu-central-1:941128203839:log-group:/ecs/opensearch-rag:*",
          "arn:aws:logs:eu-central-1:941128203839:log-group:/ecs/wpp-server:*"
        ]
      }
    ]
  })
}

# AWS Services Access Policy (AppSync, Bedrock, etc.)
resource "aws_iam_policy" "aws_services_policy" {
  name        = "ecs-aws-services-policy"
  description = "Policy for accessing specific AWS services"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "appsync:GraphQL",
          "bedrock:InvokeModel",
          "bedrock:ListFoundationModels"
        ]
        Resource = [
          "arn:aws:appsync:eu-central-1:941128203839:apis/l7iui3uwc5cqvhkoei3hss35n4",  # AppSync API
          "arn:aws:bedrock:eu-central-1::foundation-model/amazon/titan-text-express-v1",
          "arn:aws:bedrock:eu-central-1::foundation-model/amazon/titan-embed-text-v1"
        ]
      }
    ]
  })
}
