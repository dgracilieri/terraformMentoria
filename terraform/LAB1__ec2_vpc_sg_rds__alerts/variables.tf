locals{ 
  tags = {
    #type    = map(string)
      marca   = var.marca
      environment = var.environment
      responsable = var.responsable
    }
}
//Ingresar la region sobre la cual se va a trabajar
variable "aws_region" {
  default = "us-east-1"
}
//Confirmar la ruta del archivo de credenciales. Por defecto se encuentra en ~/.aws/credentials
variable "CRTfile" {
  default = ["~/.aws/credentials"]
}
//Ingresar perfil de AWS CLI con el cual se va a trabajar
variable "profile" {
  default =  "personal" 
}

//Ingresar la marca propietaria del proyecto
//Use inicial en mayúscula
variable "marca" {
  default = "CloudOps-Mentoria"
}
//Use DEV/QA/PDN para indicar que tipo de ambiente desplegará
variable "environment" {
  default = "DEV"
}
//Indique el responsable de la administración de la infraestructura
variable "responsable" {
  default = "me"
}

//Indique el cidrblock para la VPC, validar que el segmento seleccionado no se use en otra cuenta
//ejemplo default = "10.89.0.0/16"  se recomienta usar segmentos con mascara /16
variable "cidrblock" {
  default = "10.89.0.0/16"
}
