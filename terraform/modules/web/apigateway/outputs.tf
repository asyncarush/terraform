output "api_details" {
  description = "Details of created API Gateways"
  value = {
    for key, api in aws_api_gateway_rest_api.apis : key => {
      id                = api.id
      root_resource_id  = api.root_resource_id
      execution_arn     = api.execution_arn
      name              = api.name
    }
  }
}

output "api_deployment_details" {
  description = "Details of API Gateway deployments"
  value = {
    for key, deployment in aws_api_gateway_deployment.api_deployments : key => {
      id = deployment.id
    }
  }
}

output "api_stage_details" {
  description = "Details of API Gateway stages"
  value = {
    for key, stage in aws_api_gateway_stage.api_stages : key => {
      id = stage.id
    }
  }
}

# Specific output for the authorizer (if exists)
output "rest_authorizer_id" {
  description = "ID of the REST API Authorizer"
  value       = length(aws_api_gateway_authorizer.rest_authorizer) > 0 ? aws_api_gateway_authorizer.rest_authorizer[0].id : null
}
