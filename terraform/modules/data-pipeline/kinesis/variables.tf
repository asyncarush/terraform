variable "stream_name" {
  description = "Name of the Kinesis stream"
  type        = string
  default     = "data-stream"
}

variable "shard_count" {
  description = "Number of shards in the Kinesis stream"
  type        = number
  default     = 1
}

variable "firehose_name" {
  description = "Name of the Kinesis Firehose delivery stream"
  type        = string
  default     = "firehose-delivery-stream"
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda and Firehose"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket for Firehose destination"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function for data transformation"
  type        = string
  default     = null
}

variable "buffer_size" {
  description = "Buffer size for Firehose in MB"
  type        = number
  default     = 5
}

variable "buffer_interval" {
  description = "Buffer interval for Firehose in seconds"
  type        = number
  default     = 300
}

variable "environment" {
  description = "Environment tag for Kinesis resources"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC ID for private subnet configuration"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for Kinesis resources"
  type        = list(string)
}

variable "vpc_security_group_id" {
  description = "Security group ID for VPC resources"
  type        = string
}
