variable "role_name" {
  description = "Name of the IAM role for data pipeline"
  type        = string
  default     = "data-pipeline-execution-role"
}

variable "environment" {
  description = "Environment tag for IAM resources"
  type        = string
  default     = "dev"
}

variable "dynamodb_table_arns" {
  description = "List of DynamoDB table ARNs to access"
  type        = list(string)
  default     = []
}

variable "kinesis_stream_arns" {
  description = "List of Kinesis stream ARNs to access"
  type        = list(string)
  default     = []
}

variable "firehose_stream_arns" {
  description = "List of Kinesis Firehose stream ARNs to access"
  type        = list(string)
  default     = []
}

variable "s3_bucket_arns" {
  description = "List of S3 bucket ARNs to access"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID for private subnet configuration"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for resources"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
}
