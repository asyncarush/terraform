variable "cognito_user_pool_arn" {
  description = "ARN of the Cognito User Pool for API Gateway authorization"
  type        = string
  default     = "arn:aws:cognito-idp:REGION:ACCOUNT_ID:userpool/POOL_ID"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "prod"
}

variable "api_gateways" {
  description = "Configuration for API Gateways"
  type = map(object({
    name                         = string
    api_key_source               = optional(string, "HEADER")
    disable_execute_api_endpoint = optional(bool, false)
    endpoint_configuration_type  = optional(string, "REGIONAL")
    tags                         = optional(map(string), {})
  }))
  default = {
    "restAuthorizer" = {
      name = "restAuthorizer"
      tags = {}
    },
    "createFlow" = {
      name = "createFlow"
      tags = {}
    },
    "webhookNode" = {
      name = "webhookNode"
      endpoint_configuration_type = "EDGE"
      tags = {
        "user:Application" = "halo"
        "user:Stack"       = "dev"
      }
    }
  }
}
