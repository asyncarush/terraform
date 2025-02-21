variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "apis" {
  description = "Map of AppSync APIs with their configurations"
  type = map(object({
    authentication_type    = string
    schema                 = string
    log_level              = optional(string, "NONE")
    dynamodb_table_name    = optional(string)
  }))
  default = {}
}
