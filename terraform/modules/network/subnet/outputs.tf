output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id]
}
