# Amplify App Configuration
resource "aws_amplify_app" "lifedata_apps" {
  for_each = var.amplify_apps

  name       = each.value.app_name
  repository = each.value.repository_url

  # Build specification
  build_spec = each.value.build_spec

  # Optional access token for private repositories
  access_token = lookup(each.value, "access_token", null)

  # Custom rules for single-page applications
  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }

  tags = {
    Name        = each.value.app_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Amplify Branch Configuration
resource "aws_amplify_branch" "app_branches" {
  for_each = var.amplify_apps

  app_id      = aws_amplify_app.lifedata_apps[each.key].id
  branch_name = lookup(each.value, "branch_name", "main")

  stage           = var.stage_environment
  enable_auto_build = true

  tags = {
    Name        = "${each.value.app_name}-branch"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
