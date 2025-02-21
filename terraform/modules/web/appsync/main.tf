# IAM Role for AppSync
resource "aws_iam_role" "appsync_role" {
  name = "${var.environment}-appsync-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "appsync.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.environment}-appsync-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# AppSync GraphQL APIs
resource "aws_appsync_graphql_api" "apis" {
  for_each = var.apis

  authentication_type = each.value.authentication_type
  name                = each.key

  schema = each.value.schema

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_role.arn
    field_log_level          = each.value.log_level
  }

  tags = {
    Name        = each.key
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Optional: AppSync Data Sources
resource "aws_appsync_datasource" "dynamodb_sources" {
  for_each = { 
    for key, api in var.apis : key => api 
    if api.dynamodb_table_name != null 
  }

  api_id      = aws_appsync_graphql_api.apis[each.key].id
  name        = "${each.key}-dynamodb-source"
  type        = "AMAZON_DYNAMODB"
  
  dynamodb_config {
    table_name = each.value.dynamodb_table_name
  }

  service_role_arn = aws_iam_role.appsync_role.arn
}
