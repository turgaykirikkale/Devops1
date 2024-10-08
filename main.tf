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

//Subnets 
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
  name                    = "private_subnet ${module.vpc.vpc_name}"
  availability_zone_index = 1
}

//Creating S3 Bucket
module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = "s3-bucket-001-01"
}

//IAM role's creating
module "iam_role_001" {
  source                = "./modules/iam"
  role_name             = "iam-role-001-01"
  instance_profile_name = "iam-instance-profile-name-001-01"
  s3_bucket_arn         = module.s3_bucket.bucket_arn
  s3_bucket_name        = module.s3_bucket.bucket_name
}
//Security Groups
module "security_group_public" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = "public_sg"
}

module "security_group_private" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  allowed_ports = [22]
  allowed_cidrs = ["${module.public_instace.instance_private_ip}/32"]
  sg_name       = "private_sg"
}


//I need to have to put IGW for my VPC for connection to the ınternet for VPC 
module "internet_gateway" {
  source   = "./modules/igw"
  vpc_name = module.vpc.vpc_name
  vpc_id   = module.vpc.vpc_id
}

//I need to  have to NATGateway for my private instance's outbound connection
module "Nat_Gateway" {
  source           = "./modules/NATGateway"
  public_subnet_id = module.public_subnet.subnet_id
  tags = {
    Name = "NatGateway_${module.vpc.vpc_name}"
  }
  internet_gateway = module.internet_gateway.igw_id
}


//I have to add route tables for redirecting my internet connection to Subnets.
//--->private_rt
module "private_rt" {
  source            = "./modules/routetable"
  vpc_id            = module.vpc.vpc_id
  rt_name           = "private_rt"
  private_subnet_id = module.private_subnet.subnet_id
  public_subnet_id  = module.public_subnet.subnet_id
  nat_gateway_id    = module.Nat_Gateway.nat_gateway_id
  is_public         = false
}

//--->public_rt
module "public_rt" {
  source              = "./modules/routetable"
  vpc_id              = module.vpc.vpc_id
  rt_name             = "public_rt"
  private_subnet_id   = module.private_subnet.subnet_id
  public_subnet_id    = module.public_subnet.subnet_id
  internet_gateway_id = module.internet_gateway.igw_id
  is_public           = true
}


//My instances  
module "public_instace" {
  source              = "./modules/ec2"
  subnet_id           = module.public_subnet.subnet_id
  instance_type       = "t3.micro"
  instance_name       = "public_instance"
  use_security_groups = [module.security_group_public.security_group.id]
  instance_profile    = module.iam_role_001.instance_profile_id
  user_data_script    = <<-EOF
  #!/bin/bash
  set -x  # Debug mode open
  echo "staterted" > /tmp/debug.log
  sudo apt-get update -y
  echo "apt-get update completed" >> /tmp/debug.log
  sudo apt-get install -y awscli  # AWS CLI'ı upload
  echo "AWS CLI uploaded" >> /tmp/debug.log
  echo "Hello, this is a test file!" > /tmp/turgay.txt
  echo "Dosya was created" >> /tmp/debug.log
  aws s3 cp /tmp/turgay.txt s3://${module.s3_bucket.bucket_name}/turgay.txt
  echo "Dosya uploaded" >> /tmp/debug.log
EOF


}
module "private_instace" {
  source              = "./modules/ec2"
  subnet_id           = module.private_subnet.subnet_id
  instance_type       = "t3.micro"
  instance_name       = "private_instance ${module.vpc.vpc_name}"
  use_security_groups = [module.security_group_private.security_group.id]
}



output "user_data_script" {
  value = module.public_instace.user_data_script
}

output "s5" {
  value = module.s3_bucket.bucket_arn
}

output "s3_name" {
  value = module.s3_bucket.bucket_name
}
