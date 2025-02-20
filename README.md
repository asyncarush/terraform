# Terraform AWS Network Infrastructure

## Project Structure

```
terraform/
├── environments/
│   └── dev/
│       ├── main.tf       # Main configuration for dev environment
│       └── provider.tf   # Provider configuration
└── modules/
    └── network/
        ├── vpc/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── subnet/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── nat/
        │   ├── main.tf
        │   └── outputs.tf
        ├── routes/
        │   └── main.tf
        └── internet-gateway/
            └── main.tf
```

## Getting Started

1. Navigate to `terraform/environments/dev`
2. Run `terraform init`
3. Run `terraform plan`
4. Run `terraform apply`

## Modules

- `vpc`: Defines the VPC configuration
- `subnet`: Creates public and private subnets
- `nat`: Sets up NAT Gateway for private subnets
- `routes`: Configures route tables
- `internet-gateway`: Creates Internet Gateway

## Customization

Modify variables in each module's `variables.tf` to customize your infrastructure.
