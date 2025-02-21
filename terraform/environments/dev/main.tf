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
  vpc_cidr           = module.vpc.cidr_block
  private_subnet_ids = module.subnet.private_subnet_ids
}

module "dynamodb" {
  source = "../../modules/data-pipeline/dynamodb"
  
  table_name     = "lifedata-dev"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  environment    = "dev"
}

module "s3" {
  source = "../../modules/data-pipeline/s3"
  
  bucket_name  = "lifedata-data-pipeline-dev"
  environment  = "dev"
  
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.subnet.private_subnet_ids
  vpc_cidr_block     = module.vpc.cidr_block
}

module "iam" {
  source = "../../modules/data-pipeline/iam"
  
  role_name     = "lifedata-pipeline-role-dev"
  environment   = "dev"
  
  dynamodb_table_arns   = [module.dynamodb.table_arn]
  s3_bucket_arns        = [module.s3.bucket_arn]
  
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.subnet.private_subnet_ids
  vpc_cidr_block     = module.vpc.cidr_block
}

module "lambda" {
  source = "../../modules/data-pipeline/lambda"
  
  function_name     = "lifedata-transformation-dev"
  lambda_role_arn   = module.iam.role_arn
  lambda_zip_path   = "../../lambda/transformation.zip"
  environment       = "dev"
  
  vpc_id             = module.vpc.vpc_id
  vpc_cidr             = module.vpc.cidr_block
  private_subnet_ids = module.subnet.private_subnet_ids
  vpc_security_group_id = module.iam.role_id
}

module "kinesis" {
  source = "../../modules/data-pipeline/kinesis"
  
  stream_name     = "lifedata-stream-dev"
  firehose_name   = "lifedata-firehose-dev"
  environment     = "dev"
  
  lambda_role_arn   = module.iam.role_arn
  s3_bucket_arn     = module.s3.bucket_arn
  lambda_arn        = module.lambda.lambda_function_arn
  
  vpc_id             = module.vpc.vpc_id
  vpc_cidr             = module.vpc.cidr_block
  private_subnet_ids = module.subnet.private_subnet_ids
  vpc_security_group_id = module.iam.role_id
}