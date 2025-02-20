resource "aws_vpc" "lifedata-dev-infra" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        "environment" = "dev"
        "Name" = "lifedata-dev-infra-vpc"
    }
}