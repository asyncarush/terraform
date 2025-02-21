# Security Group for Lambda
resource "aws_security_group" "lambda_sg" {
  name        = "${var.function_name}-lambda-sg"
  description = "Security group for Lambda function"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.function_name}-lambda-sg"
    Environment = var.environment
  }
}

# Retrieve VPC Details
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Lambda Function Configuration

resource "aws_lambda_function" "transformation_lambda" {
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.lambda_zip_path

  # VPC Configuration
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = var.environment_variables
  }

  tags = {
    Name        = var.function_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Optional Lambda Permissions
resource "aws_lambda_permission" "allow_kinesis_invoke" {
  count         = var.kinesis_stream_arn != null ? 1 : 0
  statement_id  = "AllowKinesisInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.transformation_lambda.function_name
  principal     = "kinesis.amazonaws.com"
  source_arn    = var.kinesis_stream_arn
}
