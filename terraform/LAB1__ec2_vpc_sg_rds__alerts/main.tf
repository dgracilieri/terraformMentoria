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

module "virtual_net" {
  source = "./modules/aws_vpc"
}