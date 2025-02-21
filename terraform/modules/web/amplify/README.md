# AWS Amplify Module

## Overview

This Terraform module configures an AWS Amplify application with comprehensive deployment and hosting capabilities.

## Features

- Configurable Git repository integration
- Automatic build and deployment
- Environment variable management
- Custom domain support
- Single-page application (SPA) routing
- Flexible framework support

## Usage Example

```hcl
module "lifedata_web" {
  source = "./modules/web/amplify"

  app_name     = "lifedata-web"
  repository_url = "https://github.com/your-org/lifedata-web"
  branch_name  = "main"

  environment_variables = {
    REACT_APP_API_URL = "https://api.lifedata.com"
  }

  platform    = "WEB"
  framework   = "React"
}
```

## Variables

- `app_name`: Name of the Amplify application
- `repository_url`: Git repository URL
- `branch_name`: Branch to deploy (default: main)
- `environment_variables`: App-level environment variables
- `platform`: Web platform (default: WEB)
- `framework`: Web framework (default: React)

## Outputs

- `amplify_app_id`: Unique Amplify app identifier
- `amplify_branch_url`: Deployed branch URL
- `custom_domain_url`: Custom domain URL (if configured)

## Security Considerations

- Use environment variables for sensitive configuration
- Implement least-privilege IAM roles
- Use access tokens securely

## Customization

Modify variables to adapt to your specific web application requirements.
