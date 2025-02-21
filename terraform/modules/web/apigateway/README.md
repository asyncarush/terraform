# API Gateway Terraform Module

## Overview
This Terraform module creates an AWS API Gateway with specific resources and configurations.

## Resources Created
- REST API
- Authorizer (Cognito User Pools)
- `/createFlow` endpoint
- `/webhookNode` endpoint
- API Deployment
- API Stage

## Usage Example

```hcl
module "api_gateway" {
  source = "./modules/web/apigateway"

  cognito_user_pool_arn = aws_cognito_user_pool.example.arn
  environment           = "dev"
  stage_name            = "prod"
}
```

## Variables
- `cognito_user_pool_arn`: ARN of the Cognito User Pool for authorization
- `environment`: Deployment environment
- `stage_name`: API Gateway stage name

## Outputs
- `rest_api_id`: ID of the created REST API
- `rest_authorizer_id`: ID of the REST API Authorizer
- `create_flow_resource_id`: Resource ID for createFlow endpoint
- `webhook_node_resource_id`: Resource ID for webhookNode endpoint

## Authorization
- `/createFlow`: Cognito User Pools Authorization
- `/webhookNode`: No authorization (configurable)

## Customization
Modify the module variables and resources to fit your specific API requirements.
