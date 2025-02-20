variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet configurations"
  type = list(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  default = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      name              = "Private Subnet 1"
    },
    {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      name              = "Private Subnet 2"
    }
  ]
}

variable "public_subnets" {
  description = "List of public subnet configurations"
  type = list(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  default = [
    {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1a"
      name              = "Public Subnet 1"
    },
    {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1b"
      name              = "Public Subnet 2"
    }
  ]
}
