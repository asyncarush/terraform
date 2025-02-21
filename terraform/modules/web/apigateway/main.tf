# API Gateway Resources

resource "aws_api_gateway_rest_api" "apis" {
  for_each = var.api_gateways

  name                         = each.value.name
  api_key_source               = each.value.api_key_source
  disable_execute_api_endpoint = each.value.disable_execute_api_endpoint
  
  endpoint_configuration {
    types = [each.value.endpoint_configuration_type]
  }

  tags = each.value.tags
}

# Authorizer for REST API (only for restAuthorizer)
resource "aws_api_gateway_authorizer" "rest_authorizer" {
  count = contains(keys(var.api_gateways), "restAuthorizer") ? 1 : 0

  name                   = "restAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.apis["restAuthorizer"].id
  type                   = "COGNITO_USER_POOLS"
  provider_arns          = [var.cognito_user_pool_arn]
}

# Create Flow Resource
resource "aws_api_gateway_resource" "create_flow" {
  rest_api_id = aws_api_gateway_rest_api.apis["createFlow"].id
  parent_id   = aws_api_gateway_rest_api.apis["createFlow"].root_resource_id
  path_part   = "createFlow"
}

# Webhook Node Resource
resource "aws_api_gateway_resource" "webhook_node" {
  rest_api_id = aws_api_gateway_rest_api.apis["webhookNode"].id
  parent_id   = aws_api_gateway_rest_api.apis["webhookNode"].root_resource_id
  path_part   = "webhookNode"
}

# Deployments for each API
resource "aws_api_gateway_deployment" "api_deployments" {
  for_each = var.api_gateways

  rest_api_id = aws_api_gateway_rest_api.apis[each.key].id
  stage_name  = var.stage_name
}

# Stages for each API
resource "aws_api_gateway_stage" "api_stages" {
  for_each = var.api_gateways

  deployment_id = aws_api_gateway_deployment.api_deployments[each.key].id
  rest_api_id   = aws_api_gateway_rest_api.apis[each.key].id
  stage_name    = var.stage_name
}