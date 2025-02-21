[
    {
        "taskDefinitionArn": "arn:aws:ecs:eu-central-1:941128203839:task-definition/flowise-ld-TaskDefinitionFlowise-AnWVUMNBJ1nU:2",
        "containerDefinitions": [
            {
                "name": "flowise-service",
                "image": "941128203839.dkr.ecr.eu-central-1.amazonaws.com/flowise:latest",
                "cpu": 0,
                "portMappings": [
                    {
                        "containerPort": 3000,
                        "hostPort": 3000,
                        "protocol": "tcp"
                    }
                ],
                "essential": true,
                "command": [
                    "pnpm",
                    "start"
                ],
                "environment": [
                    {
                        "name": "FLOWISE_PASSWORD",
                        "value": "LIFEdata#23"
                    },
                    {
                        "name": "DATABASE_NAME",
                        "value": ""
                    },
                    {
                        "name": "FLOWISE_USERNAME",
                        "value": "mithun.h@variantlabs.in"
                    },
                    {
                        "name": "DATABASE_PATH",
                        "value": "/root/.flowise"
                    },
                    {
                        "name": "DATABASE_HOST",
                        "value": ""
                    },
                    {
                        "name": "Port",
                        "value": "3000"
                    },
                    {
                        "name": "DATABASE_PORT",
                        "value": ""
                    },
                    {
                        "name": "SECRETKEY_PATH",
                        "value": "/root/.flowise"
                    },
                    {
                        "name": "CORS_ORIGINS",
                        "value": "*"
                    },
                    {
                        "name": "FLOWISE_SECRETKEY_OVERWRITE",
                        "value": ""
                    },
                    {
                        "name": "DEBUG",
                        "value": "true"
                    },
                    {
                        "name": "LOG_PATH",
                        "value": "/root/.flowise/logs"
                    },
                    {
                        "name": "DATABASE_SSL",
                        "value": ""
                    },
                    {
                        "name": "IFRAME_ORIGINS",
                        "value": ""
                    },
                    {
                        "name": "FLOWISE_FILE_SIZE_LIMIT",
                        "value": ""
                    },
                    {
                        "name": "DATABASE_TYPE",
                        "value": ""
                    },
                    {
                        "name": "BLOB_STORAGE_PATH",
                        "value": "/root/.flowise/storage"
                    },
                    {
                        "name": "APIKEY_PATH",
                        "value": "/root/.flowise"
                    },
                    {
                        "name": "DISABLE_FLOWISE_TELEMETRY",
                        "value": ""
                    },
                    {
                        "name": "TOOL_FUNCTION_EXTERNAL_DEP",
                        "value": "json-logic-js"
                    },
                    {
                        "name": "LOG_LEVEL",
                        "value": "debug"
                    },
                    {
                        "name": "DATABASE_USER",
                        "value": ""
                    },
                    {
                        "name": "DATABASE_PASSWORD",
                        "value": ""
                    },
                    {
                        "name": "DATABASE_SSL_KEY_BASE64",
                        "value": ""
                    }
                ],
                "mountPoints": [
                    {
                        "sourceVolume": "efs-volume",
                        "containerPath": "/root/.flowise"
                    }
                ],
                "volumesFrom": [],
                "dockerLabels": {},
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-group": "flowise-ld",
                        "awslogs-region": "eu-central-1",
                        "awslogs-stream-prefix": "flowise"
                    }
                },
                "systemControls": []
            }
        ],
        "family": "flowise-ld-TaskDefinitionFlowise-AnWVUMNBJ1nU",
        "executionRoleArn": "arn:aws:iam::941128203839:role/flowise-ld-ECSTaskExecutionRole-kEG925gRGR2S",
        "networkMode": "awsvpc",
        "revision": 2,
        "volumes": [
            {
                "name": "efs-volume",
                "efsVolumeConfiguration": {
                    "fileSystemId": "fs-06ac48d8379275808",
                    "rootDirectory": "/",
                    "transitEncryption": "ENABLED"
                }
            }
        ],
        "status": "ACTIVE",
        "requiresAttributes": [
            {
                "name": "com.amazonaws.ecs.capability.logging-driver.awslogs"
            },
            {
                "name": "ecs.capability.execution-role-awslogs"
            },
            {
                "name": "ecs.capability.efsAuth"
            },
            {
                "name": "com.amazonaws.ecs.capability.ecr-auth"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.19"
            },
            {
                "name": "ecs.capability.efs"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.25"
            },
            {
                "name": "ecs.capability.execution-role-ecr-pull"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
            },
            {
                "name": "ecs.capability.task-eni"
            }
        ],
        "placementConstraints": [],
        "compatibilities": [
            "EC2",
            "FARGATE"
        ],
        "requiresCompatibilities": [
            "FARGATE"
        ],
        "cpu": "512",
        "memory": "1024",
        "registeredAt": "2024-06-11T07:40:39.814Z",
        "registeredBy": "arn:aws:iam::941128203839:user/mithun",
        "tags": []
    }
]