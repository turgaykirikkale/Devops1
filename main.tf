provider "aws" {
  region = "us-east-1"
  //environment Access ve Secret Acces Key
}
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "000001"
  vpc_cidr_block = "10.0.0.0/16"
}
module "public_subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  type                    = "Public"
  cidr_block              = cidrsubnet(module.vpc.vpc_cidr_block, 8, 100)
  map_public_ip_on_launch = true
  availability_zones      = data.aws_availability_zones.available.names
  environment             = "Dev"
  name                    = "public_subnet"
  availability_zone_index = 0
}
module "private_subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  type                    = "Private"
  cidr_block              = cidrsubnet(module.vpc.vpc_cidr_block, 8, 0)
  availability_zones      = data.aws_availability_zones.available.names
  environment             = "Dev"
  name                    = "private_subnet"
  availability_zone_index = 1
}
module "public_instace" {
  source        = "./modules/ec2"
  subnet_id     = module.public_subnet.subnet_id
  instance_type = "t3.micro"
  instance_name = "public_instance"
}
module "private_instace" {
  source        = "./modules/ec2"
  subnet_id     = module.private_subnet.subnet_id
  instance_type = "t3.micro"
  instance_name = "private_instance"
}
