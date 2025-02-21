output "amplify_app_details" {
  description = "Details of created Amplify applications"
  value = {
    for key, app in aws_amplify_app.lifedata_apps : key => {
      id             = app.id
      arn            = app.arn
      default_domain = app.default_domain
      name           = app.name
    }
  }
}

output "amplify_branch_details" {
  description = "Details of created Amplify branches"
  value = {
    for key, branch in aws_amplify_branch.app_branches : key => {
      id            = branch.id
      branch_name   = branch.branch_name
      app_id        = branch.app_id
    }
  }
}
