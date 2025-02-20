resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    "Name" = "EIP"
    "Owner" = "Vinod"
  }
  
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id

  tags = {
    "Name" = "NAT Gateway"
    "environment" = "dev"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.nat]
}