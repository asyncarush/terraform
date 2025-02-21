# DynamoDB Table Configuration

resource "aws_dynamodb_table" "data_table" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  dynamic "attribute" {
    for_each = var.additional_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  tags = {
    Name        = var.table_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
