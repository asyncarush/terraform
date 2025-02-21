output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.ld_dynamodb-table.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.ld_dynamodb-table.arn
}

output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.ld_dynamodb-table.id
}
