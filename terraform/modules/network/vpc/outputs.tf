output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.lifedata-dev-infra.id
}

output "cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.lifedata-dev-infra.cidr_block
}