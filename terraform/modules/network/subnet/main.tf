resource "aws_subnet" "private-us-east-1a" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnets[0].cidr_block
  availability_zone = var.private_subnets[0].availability_zone
  
  tags = {
    "subnet" = "private-us-east-1a"
    "Name" = var.private_subnets[0].name
  }
}

resource "aws_subnet" "private-us-east-1b" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnets[1].cidr_block
  availability_zone = var.private_subnets[1].availability_zone

  tags = {
    "subnet" = "private-us-east-1b"
    "Name" = var.private_subnets[1].name
  }
}

resource "aws_subnet" "public-us-east-1a" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnets[0].cidr_block
  availability_zone = var.public_subnets[0].availability_zone
  map_public_ip_on_launch = true

  tags = {
    "subnet" = "public-us-east-1a"
    "Name" = var.public_subnets[0].name
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnets[1].cidr_block
  availability_zone = var.public_subnets[1].availability_zone
  map_public_ip_on_launch = true

  tags = {
    "subnet" = "public-us-east-1b"
    "Name" = var.public_subnets[1].name
  }
}