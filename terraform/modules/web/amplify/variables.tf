variable "app_name" {
  description = "Name of the Amplify application"
  type        = string
}

variable "repository_url" {
  description = "URL of the Git repository"
  type        = string
}

variable "repository_access_token" {
  description = "Access token for private repository"
  type        = string
  default     = null
  sensitive   = true
}

variable "branch_name" {
  description = "Git branch to deploy"
  type        = string
  default     = "main"
}


variable "stage_environment" {
  description = "Stage Deployment environment"
  type        = string
  default     = "DEVELOPMENT" # options:["PRODUCTION" "BETA" "DEVELOPMENT" "EXPERIMENTAL" "PULL_REQUEST"]
}


variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev" # options:["PRODUCTION" "BETA" "DEVELOPMENT" "EXPERIMENTAL" "PULL_REQUEST"]
}
