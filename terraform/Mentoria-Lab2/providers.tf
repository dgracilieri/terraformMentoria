#Datos de conexion a la cuenta de AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.0"
    }
  }
}


provider "aws" {
  region     = var.aws_region
  shared_credentials_file = var.CRTfile
  profile    = var.profile
}