output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.data_table.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.data_table.arn
}

output "table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.data_table.id
}
