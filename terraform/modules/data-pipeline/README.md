# LifeData Data Pipeline Module

## Overview

This Terraform module creates a comprehensive, secure, and scalable data pipeline infrastructure using AWS services:

### Components

- **DynamoDB**: NoSQL database for data storage
- **Kinesis**: Real-time data streaming
- **Lambda**: Serverless data transformation
- **S3**: Processed data storage
- **IAM**: Secure access management

## Architecture

```
[DynamoDB] → [Kinesis Stream] → [Lambda Transform] → [Kinesis Firehose] → [S3 Bucket]
```

## Features

- Private subnet deployment
- VPC endpoint for S3
- Least-privilege IAM roles
- Encryption at rest
- Flexible configuration
- Environment-specific setup

## Prerequisites

- Terraform 1.0+
- AWS Provider
- VPC and Subnet modules

## Usage Example

```hcl
module "data_pipeline" {
  source = "./modules/data-pipeline"

  # DynamoDB Configuration
  table_name     = "lifedata-dev"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  # S3 Configuration
  bucket_name    = "lifedata-processed"

  # VPC Configuration
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.subnet.private_subnet_ids
}
```

## Security Considerations

- All resources deployed in private subnets
- S3 access via VPC endpoint
- Server-side encryption enabled
- Strict IAM policies

## Customization

Modify variables in each module's `variables.tf` to customize:

- Resource names
- Billing modes
- Encryption settings
- Access configurations

## Outputs

Each module provides outputs for:

- Resource names
- ARNs
- Identifiers

## Monitoring

- CloudWatch logs enabled
- Lambda function logging
- Kinesis stream metrics

## Cost Optimization

- PAY_PER_REQUEST billing mode
- S3 lifecycle management
- Serverless architecture

## Troubleshooting

- Check IAM permissions
- Verify VPC configurations
- Review Lambda function logs

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push and create Pull Request

## License

[Specify your license]

## Contact

[Your contact information]
