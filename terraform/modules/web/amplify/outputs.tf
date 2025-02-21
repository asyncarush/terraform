output "amplify_app_id" {
  description = "Unique ID of the Amplify application"
  value       = aws_amplify_app.lifedata_app.id
}

output "amplify_app_arn" {
  description = "ARN of the Amplify application"
  value       = aws_amplify_app.lifedata_app.arn
}

output "amplify_default_domain" {
  description = "Default Amplify-generated domain"
  value       = aws_amplify_app.lifedata_app.default_domain
}
