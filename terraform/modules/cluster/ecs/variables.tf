variable "vpc_id" {
  description = "VPC ID for the ECS cluster"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# Task Definitions
variable "task_definitions" {
  description = "Configuration for different ECS task definitions"
  type = map(object({
    family        = string
    container_name = string
    image         = string
    cpu           = number
    memory        = number
    port_mappings = list(object({
      containerPort = number
      hostPort      = number
      protocol      = string
    }))
    environment = optional(list(object({
      name  = string
      value = string
    })))
    mount_points = optional(list(object({
      source_volume  = string
      container_path = string
    })))
    volumes = optional(list(object({
      name = string
      host_path = optional(string)
      efs_volume_configuration = optional(object({
        file_system_id = string
        root_directory = string
      }))
    })))
    container_definitions = list(object({
      name  = string
      image = string
      cpu   = number
      essential = optional(bool)
      portMappings = list(object({
        containerPort = number
        hostPort      = number
        protocol      = string
      }))
      environment = optional(list(object({
        name  = string
        value = string
      })))
      mountPoints = optional(list(object({
        sourceVolume  = string
        containerPath = string
      })))
      logConfiguration = optional(object({
        logDriver = string
        options   = map(string)
      }))
    }))
  }))
  default = {
    "custom-resolver" = {
      family         = "custom-resolver-td-dev"
      container_name = "custom-resolver-container-dev"
      image          = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/custom-resolver-repo-dev:latest"
      cpu            = 256
      memory         = 512
      port_mappings = [{
        containerPort = 3000
        hostPort      = 3000
        protocol      = "tcp"
      }]
      environment = [
        { name = "STORAGE_HALO_BUCKETNAME", value = "halo-dev224054-dev" },
        { name = "AWS_LAMBDA_FUNCTION_NAME", value = "custom-resolver-dev" },
        { name = "API_HALO_GRAPHQLAPIENDPOINTOUTPUT", value = "https://l7iui3uwc5cqvhkoei3hss35n4.appsync-api.eu-central-1.amazonaws.com/graphql" },
        { name = "POWERTOOLS_TRACE_ENABLED", value = "false" },
        { name = "API_HALO_GRAPHQLAPIKEYOUTPUT", value = "da2-kql2mcxmvjdfzi47qg43q72vqy" }
      ]
      mount_points = [{
        source_volume  = "custom-resolver-efs-dev"
        container_path = "/custom-resolver"
      }]
      volumes = [{
        name = "custom-resolver-efs-dev"
        efs_volume_configuration = {
          file_system_id = "fs-12345678"
          root_directory = "/"
        }
      }]
      container_definitions = [
        {
          name  = "custom-resolver-container-dev"
          image = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/custom-resolver-repo-dev:latest"
          cpu   = 256
          essential = true
          portMappings = [{
            containerPort = 3000
            hostPort      = 3000
            protocol      = "tcp"
          }]
          environment = [
            { name = "STORAGE_HALO_BUCKETNAME", value = "halo-dev224054-dev" },
            { name = "AWS_LAMBDA_FUNCTION_NAME", value = "custom-resolver-dev" },
            { name = "API_HALO_GRAPHQLAPIENDPOINTOUTPUT", value = "https://l7iui3uwc5cqvhkoei3hss35n4.appsync-api.eu-central-1.amazonaws.com/graphql" },
            { name = "POWERTOOLS_TRACE_ENABLED", value = "false" },
            { name = "API_HALO_GRAPHQLAPIKEYOUTPUT", value = "da2-kql2mcxmvjdfzi47qg43q72vqy" }
          ]
          mountPoints = [{
            sourceVolume  = "custom-resolver-efs-dev"
            containerPath = "/custom-resolver"
          }]
          logConfiguration = {
            logDriver = "awslogs"
            options = {
              "awslogs-group"         = "/ecs/custom-resolver"
              "awslogs-region"        = "eu-central-1"
              "awslogs-stream-prefix" = "ecs"
            }
          }
        }
      ]
    },
    "flowise" = {
      family         = "flowise-ld"
      container_name = "flowise-service"
      image          = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/flowise:latest"
      cpu            = 256
      memory         = 512
      port_mappings = [{
        containerPort = 3000
        hostPort      = 3000
        protocol      = "tcp"
      }]
      environment = [
        { name = "FLOWISE_PASSWORD", value = "LIFEdata#23" },
        { name = "DATABASE_NAME", value = "" },
        { name = "FLOWISE_USERNAME", value = "mithun.h@variantlabs.in" },
        { name = "DATABASE_PATH", value = "/root/.flowise" },
        { name = "DATABASE_HOST", value = "" },
        { name = "Port", value = "3000" },
        { name = "DATABASE_PORT", value = "" }
      ]
      mount_points = [{
        source_volume  = "efs-volume"
        container_path = "/root/.flowise"
      }]
      volumes = [{
        name = "efs-volume"
        efs_volume_configuration = {
          file_system_id = "fs-06ac48d8379275808"
          root_directory = "/"
        }
      }]
      container_definitions = [
        {
          name  = "flowise-service"
          image = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/flowise:latest"
          cpu   = 256
          essential = true
          portMappings = [{
            containerPort = 3000
            hostPort      = 3000
            protocol      = "tcp"
          }]
          environment = [
            { name = "FLOWISE_PASSWORD", value = "LIFEdata#23" },
            { name = "DATABASE_NAME", value = "" },
            { name = "FLOWISE_USERNAME", value = "mithun.h@variantlabs.in" },
            { name = "DATABASE_PATH", value = "/root/.flowise" },
            { name = "DATABASE_HOST", value = "" },
            { name = "Port", value = "3000" },
            { name = "DATABASE_PORT", value = "" }
          ]
          mountPoints = [{
            sourceVolume  = "efs-volume"
            containerPath = "/root/.flowise"
          }]
          logConfiguration = {
            logDriver = "awslogs"
            options = {
              "awslogs-group"         = "/ecs/flowise"
              "awslogs-region"        = "eu-central-1"
              "awslogs-stream-prefix" = "ecs"
            }
          }
        }
      ]
    },
    "opensearch-rag" = {
      family         = "opensearch-rag-services"
      container_name = "opensearch-rag-service"
      image          = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/rag-opensearch"
      cpu            = 1024
      memory         = 3072
      port_mappings = [{
        containerPort = 5000
        hostPort      = 5000
        protocol      = "tcp"
      }]
      environment = [
        { name = "ENDPOINT", value = "https://search-amplify-opense-1j63fdvnd3145-y2i6tlfdp4s55jlxvohlvmx6g4.eu-central-1.es.amazonaws.com:443" },
        { name = "TEXT_MODEL_NAME", value = "amazon.titan-text-express-v1" },
        { name = "INDEX_NAME", value = "fallback_rag" },
        { name = "BEDROCK_MODEL_NAME", value = "amazon.titan-embed-text-v1" }
      ]
      container_definitions = [
        {
          name  = "opensearch-rag-service"
          image = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/rag-opensearch"
          cpu   = 1024
          essential = true
          portMappings = [{
            containerPort = 5000
            hostPort      = 5000
            protocol      = "tcp"
          }]
          environment = [
            { name = "ENDPOINT", value = "https://search-amplify-opense-1j63fdvnd3145-y2i6tlfdp4s55jlxvohlvmx6g4.eu-central-1.es.amazonaws.com:443" },
            { name = "TEXT_MODEL_NAME", value = "amazon.titan-text-express-v1" },
            { name = "INDEX_NAME", value = "fallback_rag" },
            { name = "BEDROCK_MODEL_NAME", value = "amazon.titan-embed-text-v1" }
          ]
          logConfiguration = {
            logDriver = "awslogs"
            options = {
              "awslogs-group"         = "/ecs/opensearch-rag"
              "awslogs-region"        = "eu-central-1"
              "awslogs-stream-prefix" = "ecs"
            }
          }
        }
      ]
    },
    "wpp-server" = {
      family         = "wpp-server-td-dev"
      container_name = "wpp-server-container-dev"
      image          = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/wpp-server-repo-dev:latest"
      cpu            = 256
      memory         = 512
      port_mappings = [{
        containerPort = 21465
        hostPort      = 21465
        protocol      = "tcp"
      }]
      mount_points = [{
        source_volume  = "wpp-server-efs-dev"
        container_path = "/home/node/app/wpp-server-user-data"
      }]
      volumes = [{
        name = "wpp-server-efs-dev"
        efs_volume_configuration = {
          file_system_id = "fs-87654321"
          root_directory = "/"
        }
      }]
      container_definitions = [
        {
          name  = "wpp-server-container-dev"
          image = "941128203839.dkr.ecr.eu-central-1.amazonaws.com/wpp-server-repo-dev:latest"
          cpu   = 256
          essential = true
          portMappings = [{
            containerPort = 21465
            hostPort      = 21465
            protocol      = "tcp"
          }]
          mountPoints = [{
            sourceVolume  = "wpp-server-efs-dev"
            containerPath = "/home/node/app/wpp-server-user-data"
          }]
          logConfiguration = {
            logDriver = "awslogs"
            options = {
              "awslogs-group"         = "/ecs/wpp-server"
              "awslogs-region"        = "eu-central-1"
              "awslogs-stream-prefix" = "ecs"
            }
          }
        }
      ]
    }
  }
}