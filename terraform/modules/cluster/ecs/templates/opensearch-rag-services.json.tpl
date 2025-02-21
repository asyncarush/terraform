[

    {
        "taskDefinitionArn": "arn:aws:ecs:eu-central-1:941128203839:task-definition/opensearch-rag-services:3",
        "containerDefinitions": [
            {
                "name": "opensearch-rag-service",
                "image": "941128203839.dkr.ecr.eu-central-1.amazonaws.com/rag-opensearch",
                "cpu": 1024,
                "memory": 3072,
                "memoryReservation": 1024,
                "portMappings": [
                    {
                        "name": "services-app-endpoint",
                        "containerPort": 5000,
                        "hostPort": 5000,
                        "protocol": "tcp",
                        "appProtocol": "http"
                    }
                ],
                "essential": true,
                "environment": [
                    {
                        "name": "ENDPOINT",
                        "value": "https://search-amplify-opense-1j63fdvnd3145-y2i6tlfdp4s55jlxvohlvmx6g4.eu-central-1.es.amazonaws.com:443"
                    },
                    {
                        "name": "TEXT_MODEL_NAME",
                        "value": "amazon.titan-text-express-v1"
                    },
                    {
                        "name": "INDEX_NAME",
                        "value": "fallback_rag"
                    },
                    {
                        "name": "BEDROCK_MODEL_NAME",
                        "value": "amazon.titan-embed-text-v1"
                    }
                ],
                "environmentFiles": [],
                "mountPoints": [],
                "volumesFrom": [],
                "ulimits": [],
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-group": "/ecs/opensearch-rag-services",
                        "mode": "non-blocking",
                        "awslogs-create-group": "true",
                        "max-buffer-size": "25m",
                        "awslogs-region": "eu-central-1",
                        "awslogs-stream-prefix": "ecs"
                    },
                    "secretOptions": []
                },
                "systemControls": []
            }
        ],
        "family": "opensearch-rag-services",
        "taskRoleArn": "arn:aws:iam::941128203839:role/ecs_opensearch_rag",
        "executionRoleArn": "arn:aws:iam::941128203839:role/ecsTaskExecutionRole",
        "networkMode": "awsvpc",
        "revision": 3,
        "volumes": [],
        "status": "ACTIVE",
        "requiresAttributes": [
            {
                "name": "com.amazonaws.ecs.capability.logging-driver.awslogs"
            },
            {
                "name": "ecs.capability.execution-role-awslogs"
            },
            {
                "name": "com.amazonaws.ecs.capability.ecr-auth"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.19"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.28"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.21"
            },
            {
                "name": "com.amazonaws.ecs.capability.task-iam-role"
            },
            {
                "name": "ecs.capability.execution-role-ecr-pull"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
            },
            {
                "name": "ecs.capability.task-eni"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.29"
            }
        ],
        "placementConstraints": [],
        "compatibilities": [
            "EC2",
            "FARGATE"
        ],
        "requiresCompatibilities": [],
        "cpu": "1024",
        "memory": "3072",
        "runtimePlatform": {
            "cpuArchitecture": "X86_64",
            "operatingSystemFamily": "LINUX"
        },
        "registeredAt": "2025-01-03T20:32:30.982Z",
        "registeredBy": "arn:aws:iam::941128203839:user/dataops",
        "tags": []
    }
]