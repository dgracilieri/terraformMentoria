#definicion de variables y valores locales necesarios en el despliegue de la VPC y sus componentes
#En este modulo se construye la VPC y sus componentes

variable "cidrblock" {}

variable "marca" {}

variable "environment" {}

variable "responsable" {}

// En esta sección se calculan los cidrblocks de las subredes de mascara 24 a partir del cidr /16 de la VPC
// 2 subnets publicas, para Bastion y RDS con salida a internet

locals {
  publicblock01 = cidrsubnet(var.cidrblock, 8, 10)
  rdsblock01 = cidrsubnet(var.cidrblock, 8, 20)
  PrivIPBastion = cidrhost(local.publicblock01, 10)
  subnets = [local.publicblock01, local.rdsblock01]
}

variable "subnames" {
  default = ["Public-Sub-Bastion-01","RDS-Sub01"]
}


variable "azones" {
  default = ["us-east-1c", "us-east-1d"]
}


variable "tags" {
  description = "common tags"
  type = map(string)
  default = {}
}