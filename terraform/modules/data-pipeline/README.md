# Data Pipeline Module

## Overview
This Terraform module creates a comprehensive data pipeline infrastructure using AWS services:
- DynamoDB for data storage
- Kinesis Stream for data streaming
- Kinesis Firehose for data delivery
- Lambda for data transformation
- S3 for processed data storage

## Components
- `dynamodb/`: DynamoDB table configuration
- `kinesis/`: Kinesis Stream and Firehose configuration
- `lambda/`: Lambda function for data transformation
- `s3/`: S3 bucket for storing processed data
- `iam/`: IAM roles and policies for pipeline components

## Usage Example
```hcl
module "data_pipeline" {
  source = "./modules/data-pipeline"

  # Configure each component as needed
  dynamodb_config = {
    table_name = "my-input-data-table"
  }

  kinesis_config = {
    stream_name = "my-data-stream"
    shard_count = 1
  }

  lambda_config = {
    function_name = "data-transformation-lambda"
    lambda_zip_path = "path/to/lambda/code.zip"
  }

  s3_config = {
    bucket_name = "my-processed-data-bucket"
  }
}
```

## Security Best Practices
- Encryption at rest for S3 and DynamoDB
- IAM roles with least-privilege access
- Public access blocked for S3
- Server-side encryption for S3

## Customization
Modify variables in each component's `variables.tf` to customize the pipeline.

## Requirements
- Terraform 1.0+
- AWS Provider

## Outputs
Each module provides outputs for resource names, ARNs, and IDs for further reference.
