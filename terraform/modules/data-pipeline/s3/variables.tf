variable "bucket_name" {
  description = "Name of the S3 bucket for data storage"
  type        = string
  default     = "processed-data-bucket"
}

variable "environment" {
  description = "Environment tag for S3 resources"
  type        = string
  default     = "dev"
}

variable "lifecycle_transition_days" {
  description = "Number of days before transitioning to Infrequent Access"
  type        = number
  default     = 30
}

variable "lifecycle_expiration_days" {
  description = "Number of days before data is deleted"
  type        = number
  default     = 90
}

variable "vpc_id" {
  description = "VPC ID for S3 VPC Endpoint"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for route table association"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
}
