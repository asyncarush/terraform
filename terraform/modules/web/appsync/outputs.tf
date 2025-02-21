output "appsync_api_details" {
  description = "Details of created AppSync APIs"
  value = {
    for name, api in aws_appsync_graphql_api.apis : name => {
      id              = api.id
      arn             = api.arn
      uris            = api.uris
      name            = name
    }
  }
}

output "appsync_role_arn" {
  description = "ARN of the IAM role created for AppSync"
  value       = aws_iam_role.appsync_role.arn
}
