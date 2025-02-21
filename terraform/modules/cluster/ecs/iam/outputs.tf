# IAM Role Outputs
output "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task_role.arn
}

# IAM Policy Outputs
output "efs_access_policy_arn" {
  description = "ARN of the EFS access policy"
  value       = aws_iam_policy.efs_access_policy.arn
}

output "ecr_pull_policy_arn" {
  description = "ARN of the ECR pull policy"
  value       = aws_iam_policy.ecr_pull_policy.arn
}

output "cloudwatch_logs_policy_arn" {
  description = "ARN of the CloudWatch logs policy"
  value       = aws_iam_policy.cloudwatch_logs_policy.arn
}

output "aws_services_policy_arn" {
  description = "ARN of the AWS services policy"
  value       = aws_iam_policy.aws_services_policy.arn
}
