
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

variable "environment" {
  description = "Stage deployment environment"
  type        = string
  default     = "dev"
}


variable "stage_environment" {
  description = "Stage deployment environment"
  type        = string
  default     = "DEVELOPMENT"
}

variable "amplify_apps" {
  description = "Map of Amplify Applications with their configurations"
  type = map(object({
    repository_url         = string
    build_spec             = string
    access_token           = optional(string)
    app_name               = string
    branch_name            = optional(string, "main")
  }))
  default = {
    # Web Applications
    "lifedata-web" = {
      app_name         = "lifedata-web"
      repository_url   = "https://github.com/your-org/lifedata-web"
      branch_name      = "develop"
      build_spec       = <<-EOT
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
    },
    
    "lifedata-dashboard" = {
      app_name         = "lifedata-dashboard"
      repository_url   = "https://github.com/your-org/lifedata-dashboard"
      branch_name      = "develop"
      build_spec       = <<-EOT
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
    },
    
    # Mobile Applications
    "lifedata-mobile-ios" = {
      app_name         = "lifedata-mobile-ios"
      repository_url   = "https://github.com/your-org/lifedata-mobile-ios"
      branch_name      = "develop"
      build_spec       = <<-EOT
        version: 1
        frontend:
          phases:
            preBuild:
              commands:
                - npm install
                - pod install
            build:
              commands:
                - npm run build-ios
          artifacts:
            baseDirectory: ios/build
            files:
              - '**/*.ipa'
      EOT
    },
    
    "lifedata-mobile-android" = {
      app_name         = "lifedata-mobile-android"
      repository_url   = "https://github.com/your-org/lifedata-mobile-android"
      branch_name      = "develop"
      build_spec       = <<-EOT
        version: 1
        frontend:
          phases:
            preBuild:
              commands:
                - npm install
            build:
              commands:
                - npm run build-android
          artifacts:
            baseDirectory: android/app/build/outputs/apk
            files:
              - '**/*.apk'
      EOT
    },
    
    # Backend Services
    "lifedata-backend-api" = {
      app_name         = "lifedata-backend-api"
      repository_url   = "https://github.com/your-org/lifedata-backend-api"
      branch_name      = "develop"
      build_spec       = <<-EOT
        version: 1
        backend:
          phases:
            preBuild:
              commands:
                - npm install
            build:
              commands:
                - npm run build
          artifacts:
            baseDirectory: dist
            files:
              - '**/*'
      EOT
    },
    
    "lifedata-admin-portal" = {
      app_name         = "lifedata-admin-portal"
      repository_url   = "https://github.com/your-org/lifedata-admin-portal"
      branch_name      = "develop"
      build_spec       = <<-EOT
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
    }
  }
}
