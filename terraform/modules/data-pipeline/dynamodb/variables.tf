variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "lifedata-dev"
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
  default     = "id"
}

variable "additional_attributes" {
  description = "Additional attributes for the DynamoDB table"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "environment" {
  description = "Environment tag for the DynamoDB table"
  type        = string
  default     = "dev"
}