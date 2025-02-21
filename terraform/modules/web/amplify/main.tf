# Amplify App Configuration

resource "aws_amplify_app" "lifedata_app" {
  name       = var.app_name
  repository = var.repository_url

  # Basic build specification
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
  EOT

  access_token = var.repository_access_token

  tags = {
    Name        = var.app_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Amplify Branch Configuration
resource "aws_amplify_branch" "main_branch" {
  app_id      = aws_amplify_app.lifedata_app.id
  branch_name = var.branch_name

  stage           = var.stage_environment
  enable_auto_build = true

  tags = {
    Name        = "${var.app_name}-${var.branch_name}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
