[ 
        {
        "taskDefinitionArn": "arn:aws:ecs:eu-central-1:941128203839:task-definition/custom-resolver-td-dev:5",
        "containerDefinitions": [
            {
                "name": "custom-resolver-container-dev",
                "image": "941128203839.dkr.ecr.eu-central-1.amazonaws.com/custom-resolver-repo-dev:latest",
                "cpu": 0,
                "links": [],
                "portMappings": [
                    {
                        "name": "custom-resolver-3000-tcp",
                        "containerPort": 3000,
                        "hostPort": 3000,
                        "protocol": "tcp",
                        "appProtocol": "http"
                    }
                ],
                "essential": true,
                "entryPoint": [],
                "command": [],
                "environment": [
                    {
                        "name": "STORAGE_HALO_BUCKETNAME",
                        "value": "halo-dev224054-dev"
                    },
                    {
                        "name": "AWS_LAMBDA_FUNCTION_NAME",
                        "value": "custom-resolver-dev"
                    },
                    {
                        "name": "API_HALO_GRAPHQLAPIENDPOINTOUTPUT",
                        "value": "https://l7iui3uwc5cqvhkoei3hss35n4.appsync-api.eu-central-1.amazonaws.com/graphql"
                    },
                    {
                        "name": "POWERTOOLS_TRACE_ENABLED",
                        "value": "false"
                    },
                    {
                        "name": "API_HALO_GRAPHQLAPIKEYOUTPUT",
                        "value": "da2-kql2mcxmvjdfzi47qg43q72vqy"
                    }
                ],
                "environmentFiles": [],
                "mountPoints": [
                    {
                        "sourceVolume": "custom-resolver-efs-dev",
                        "containerPath": "/custom-resolver"
                    }
                ],
                "volumesFrom": [],
                "secrets": [],
                "dnsServers": [],
                "dnsSearchDomains": [],
                "extraHosts": [],
                "dockerSecurityOptions": [],
                "dockerLabels": {},
                "ulimits": [],
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-group": "/ecs/custom-resolver",
                        "awslogs-region": "eu-central-1",
                        "awslogs-stream-prefix": "ecs"
                    },
                    "secretOptions": []
                },
                "healthCheck": {
                    "command": [
                        "CMD-SHELL",
                        "curl -f http://localhost:3000/api/v1/health || exit 1"
                    ],
                    "interval": 30,
                    "timeout": 5,
                    "retries": 3
                },
                "systemControls": [],
                "credentialSpecs": []
            }
        ],
        "family": "custom-resolver-td-dev",
        "taskRoleArn": "arn:aws:iam::941128203839:role/custom-resolver-task-role-dev",
        "executionRoleArn": "arn:aws:iam::941128203839:role/custom-resolver-task-role-dev",
        "networkMode": "awsvpc",
        "revision": 5,
        "volumes": [
            {
                "name": "custom-resolver-efs-dev",
                "efsVolumeConfiguration": {
                    "fileSystemId": "fs-086241f1f8077a83d",
                    "rootDirectory": "/"
                }
            }
        ],
        "status": "ACTIVE",
        "requiresAttributes": [
            {
                "name": "ecs.capability.execution-role-awslogs"
            },
            {
                "name": "com.amazonaws.ecs.capability.ecr-auth"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.17"
            },
            {
                "name": "com.amazonaws.ecs.capability.task-iam-role"
            },
            {
                "name": "ecs.capability.container-health-check"
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
                "name": "com.amazonaws.ecs.capability.logging-driver.awslogs"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.24"
            },
            {
                "name": "ecs.capability.efsAuth"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.19"
            },
            {
                "name": "ecs.capability.efs"
            },
            {
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.25"
            }
        ],
        "placementConstraints": [],
        "compatibilities": [
            "EC2",
            "FARGATE"
        ],
        "cpu": "256",
        "memory": "512",
        "registeredAt": "2024-04-11T13:34:19.635Z",
        "registeredBy": "arn:aws:iam::941128203839:user/mithun",
        "tags": [
            {
                "key": "user:Application",
                "value": "halo"
            },
            {
                "key": "user:Stack",
                "value": "dev"
            }
        ]
    }
]