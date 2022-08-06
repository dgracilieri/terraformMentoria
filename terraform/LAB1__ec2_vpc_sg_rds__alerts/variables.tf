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

//Indique el cidrblock para la VPC, validar que el segmento seleccionado no se use en otra cuenta
//ejemplo default = "10.89.0.0/16"  se recomienta usar segmentos con mascara /16
variable "cidrblock" {
  default = "192.168.10/24"
}
