#definicion de variables y valores locales necesarios en el despliegue de la VPC y sus componentes
#En este modulo se construye la VPC y sus componentes

variable "cidrblock" {}
variable "marca" {}
variable "environment" {}


// En esta sección se calculan los cidrblocks de las subredes de mascara 24 a partir del cidr /16 de la VPC
// 2 subnets publicas, 2 privadas para servicios con salida a internet

locals {
  publicblock01 = cidrsubnet(var.cidrblock, 16, 1)
  publicblock02 = cidrsubnet(var.cidrblock, 16, 2)
  servicesblock01 = cidrsubnet(var.cidrblock, 8, 3)
  servicesblock02 = cidrsubnet(var.cidrblock, 8, 4)
  #estas subnets se agregan a la plantilla solo para ilustrar como puede agregar subnets
  # mediante la el parámetro adicionalsubnettag explicado mas abajo
  rdsblock01 = cidrsubnet(var.cidrblock, 8, 5)
  rdsblock02 = cidrsubnet(var.cidrblock, 8, 6)

  #Agrege aquí los cidr de las subnets que haya definido 
  subnets = [local.publicblock01, local.publicblock02, local.servicesblock01, local.servicesblock02, local.rdsblock01, local.rdsblock02]
  
  #asegurese que esta valor local tiene un numero de elementos igual 
  # En el mismo orden que se crean las subnets en el count agregue los tags
  #note que los dos ultimos espacios no tienen valor, es porque coresponden a la subnet rds 
}
#Agrege aquí los nombres de las subnets que haya definido 
variable "subnames" {
  default = ["Public-Sub01", "Public-Sub02", "Services-Sub01", "Services-Sub02", "RDS-Sub01", "RDS-Sub02"]
}


variable "azones" {
  default = ["us-east-1c", "us-east-1d", "us-east-1c", "us-east-1d", "us-east-1c", "us-east-1d"]
}


variable "tags" {
  description = "common tags"
  type = map(string)
  default = {}
}