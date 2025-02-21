variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "transformation-lambda"
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda execution"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Lambda runtime environment"
  type        = string
  default     = "python3.8"
}

variable "lambda_zip_path" {
  description = "Path to the Lambda function ZIP file"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "kinesis_stream_arn" {
  description = "ARN of the Kinesis stream to trigger the Lambda"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment tag for Lambda resources"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC ID for the ECS cluster"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for Lambda function"
  type        = list(string)
}

variable "vpc_security_group_id" {
  description = "Security group ID for Lambda function"
  type        = string
}
