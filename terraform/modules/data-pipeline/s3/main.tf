# S3 Bucket Configuration for Data Processing

resource "aws_s3_bucket" "data_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rules for data management
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_rules" {
  bucket = aws_s3_bucket.data_bucket.id

  rule {
    id     = "transition_to_infrequent_access"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }
}

# VPC Endpoint for S3
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  route_table_ids = var.private_subnet_ids

  tags = {
    Name        = "s3-vpc-endpoint"
    Environment = var.environment
  }
}

# VPC Endpoint Policy
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
        Resource = [
          aws_s3_bucket.data_bucket.arn,
          "${aws_s3_bucket.data_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Current Region Data Source
data "aws_region" "current" {}
