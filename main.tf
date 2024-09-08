provider "aws" {
  region = "us-east-1"
}
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = "devops1 env"
    Terraform   = "true"
  }
}


resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 0)
  availability_zone = data.aws_availability_zones.available.all_availability_zones
  tags = {
    Name      = "private_subnet"
    Terraform = true
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 100)
  availability_zone = data.aws_availability_zones.available.all_availability_zones
  tags = {
    Name      = "public_subnet"
    Terraform = true
  }
}

resource "aws_instance" "public_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "Public Instance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "Private Instance"
  }
}

output "vpc_name" {
  value = aws_vpc.vpc.tags.Name
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
output "aws_private_subnet_cidr" {
  value = aws_subnet.private_subnet.cidr_block
}
output "aws_public_subnet_cidr" {
  value = aws_subnet.public_subnet.cidr_block
}

output "aws_public_instance_ip" {
  value = aws_instance.public_instance.public_ip
}
output "aws_public_dns" {
  value = aws_instance.public_instance.public_dns
}
output "aws_private_intance_ip" {
  value = aws_instance.private_instance.public_ip
}

output "aws_private_intance_dns" {
  value = aws_instance.private_instance.public_dns
}
