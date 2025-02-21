# IAM Role for Data Pipeline

resource "aws_iam_role" "data_pipeline_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "firehose.amazonaws.com"
          ]
        }
      }
    ]
  })

  tags = {
    Name        = var.role_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Policy for DynamoDB Access
resource "aws_iam_role_policy" "dynamodb_policy" {
  name = "dynamodb-access-policy"
  role = aws_iam_role.data_pipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = var.dynamodb_table_arns
      }
    ]
  })
}

# Policy for Kinesis Stream and Firehose Access
resource "aws_iam_role_policy" "kinesis_policy" {
  name = "kinesis-access-policy"
  role = aws_iam_role.data_pipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kinesis:GetRecords",
          "kinesis:GetShardIterator",
          "kinesis:DescribeStream",
          "kinesis:ListShards",
          "kinesis:PutRecord",
          "kinesis:PutRecords"
        ]
        Resource = var.kinesis_stream_arns
      },
      {
        Effect = "Allow"
        Action = [
          "firehose:PutRecord",
          "firehose:PutRecordBatch"
        ]
        Resource = var.firehose_stream_arns
      }
    ]
  })
}

# Policy for S3 Access
resource "aws_iam_role_policy" "s3_policy" {
  name = "s3-access-policy"
  role = aws_iam_role.data_pipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = concat(
          var.s3_bucket_arns,
          [for bucket in var.s3_bucket_arns : "${bucket}/*"]
        )
      }
    ]
  })
}

# CloudWatch Logs Policy for Logging
resource "aws_iam_role_policy" "cloudwatch_logs_policy" {
  name = "cloudwatch-logs-policy"
  role = aws_iam_role.data_pipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# VPC Endpoint Policy for S3
resource "aws_vpc_endpoint_policy" "s3_endpoint_policy" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = concat(
          var.s3_bucket_arns,
          [for bucket in var.s3_bucket_arns : "${bucket}/*"]
        )
      }
    ]
  })
}

# S3 VPC Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  
  route_table_ids = var.private_subnet_ids

  tags = {
    Name        = "s3-vpc-endpoint"
    Environment = var.environment
  }
}

# Get current region
data "aws_region" "current" {}
