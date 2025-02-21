[
            {
                "name": "wpp-server-container-dev",
                "image": "941128203839.dkr.ecr.eu-central-1.amazonaws.com/wpp-server-repo-dev:latest",
                "cpu": 0,
                "portMappings": [
                    {
                        "name": "wpp-server-21465-tcp",
                        "containerPort": 21465,
                        "hostPort": 21465,
                        "protocol": "tcp",
                        "appProtocol": "http"
                    }
                ],
                "essential": true,
                "environment": [],
                "mountPoints": [
                    {
                        "sourceVolume": "wpp-server-efs-dev",
                        "containerPath": "/home/node/app/wpp-server-user-data"
                    }
                ],
                "volumesFrom": [],
                "dockerLabels": {},
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-group": "/ecs/wpp-server",
                        "awslogs-region": "eu-central-1",
                        "awslogs-stream-prefix": "ecs"
                    }
                },
                "healthCheck": {
                    "command": [
                        "CMD-SHELL",
                        "curl -f http://localhost:21465/healthz || exit 1"
                    ],
                    "interval": 30,
                    "timeout": 5,
                    "retries": 3
                },
                "systemControls": []
            }
        ],
        "family": "wpp-server-td-dev",
        "taskRoleArn": "arn:aws:iam::941128203839:role/wpp-server-task-role-dev",
        "executionRoleArn": "arn:aws:iam::941128203839:role/wpp-server-task-role-dev",
        "networkMode": "awsvpc",
        "revision": 12,
        "volumes": [
            {
                "name": "wpp-server-efs-dev",
                "efsVolumeConfiguration": {
                    "fileSystemId": "fs-08d3db0e3a020f7b3",
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
        "cpu": "1024",
        "memory": "3072",
        "registeredAt": "2025-02-14T17:05:33.320Z",
        "registeredBy": "arn:aws:iam::941128203839:user/dataops",
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