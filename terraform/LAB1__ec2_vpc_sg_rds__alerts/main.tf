terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.1"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  shared_credentials_files = var.CRTfile
  profile    = var.profile
}



module "ec2" {
  source = "./EC2"
}


module "vpc" {
  source = "./VPC"
  marca = var.marca
  environment = var.environment
  cidrblock = var.cidrblock
  tags = local.tags
}


module "rds" {
  source = "./RDS"
}