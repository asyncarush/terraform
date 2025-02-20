module "vpc" {
  source = "../../modules/network/vpc"
}

module "subnet" {
  source = "../../modules/network/subnet"
  vpc_id = module.vpc.vpc_id
}

module "internet_gateway" {
  source = "../../modules/network/internet-gateway"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source     = "../../modules/network/nat"
  subnet_id  = module.subnet.public_subnet_ids[0]
  depends_on = [module.internet_gateway]
}

module "routes" {
  source             = "../../modules/network/routes"
  vpc_id             = module.vpc.vpc_id
  nat_gateway_id     = module.nat.nat_gateway_id
  private_subnet_ids = module.subnet.private_subnet_ids
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  public_subnet_ids  = module.subnet.public_subnet_ids
}

module "ecs" {
  source = "../../modules/cluster/ecs"
  
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr_block
  private_subnet_ids = module.subnet.private_subnet_ids
}