# Kinesis Stream and Firehose Configuration

# VPC Configuration for Kinesis
resource "aws_security_group" "kinesis_sg" {
  name        = "${var.stream_name}-kinesis-sg"
  description = "Security group for Kinesis resources"
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
    Name        = "${var.stream_name}-kinesis-sg"
    Environment = var.environment
  }
}

# Retrieve VPC Details
data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_kinesis_stream" "data_stream" {
  name        = var.stream_name
  shard_count = var.shard_count

  tags = {
    Name        = var.stream_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  name        = var.firehose_name
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.data_stream.arn
    role_arn           = var.lambda_role_arn
  }

  s3_configuration {
    role_arn        = var.lambda_role_arn
    bucket_arn      = var.s3_bucket_arn
    buffer_size     = var.buffer_size
    buffer_interval = var.buffer_interval

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesis/firehose/${var.firehose_name}"
      log_stream_name = "S3Delivery"
    }
  }

  # VPC Configuration
  vpc_configuration {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.kinesis_sg.id]
  }

  dynamic "processing_configuration" {
    for_each = var.lambda_arn != null ? [1] : []
    content {
      enabled = true

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = var.lambda_arn
        }
      }
    }
  }

  tags = {
    Name        = var.firehose_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
