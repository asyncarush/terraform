# AWS AppSync Module

## Overview
This Terraform module configures an AWS AppSync GraphQL API with VPC private subnet deployment.

## Features
- Private subnet configuration
- Configurable authentication
- CloudWatch logging
- Optional DynamoDB data source
- Security group management

## Usage Example

```hcl
module "lifedata_appsync" {
  source = "./modules/web/appsync"

  api_name            = "lifedata-graphql"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.subnet.private_subnet_ids
  
  authentication_type = "AWS_IAM"
  log_level           = "ERROR"
}
```

## Security Considerations
- Deployed in private subnets
- Configurable authentication methods
- Least-privilege IAM roles
- Controlled network access

## Customization
Modify variables to adapt to your specific GraphQL API requirements.
