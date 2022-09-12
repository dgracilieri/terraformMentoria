//Ingresar la region sobre la cual se va a trabajar
variable "aws_region" {
  default = "us-east-1"
}

//Confirmar la ruta del archivo de credenciales. Por defecto se encuentra en ~/.aws/credentials
variable "CRTfile" {
  default = "~/.aws/credentials"
}

//Ingresar perfil de AWS CLI con el cual se va a trabajar
variable "profile" {
  default =  "personal" 
}


//Ingresar la marca propietaria del proyecto
//Use inicial en mayúscula
variable "marca" {
  default = "CloudOps_IaC"
}
//Use DEV/QA/PDN para indicar que tipo de ambiente desplegará
variable "environment" {
  default = "Dev"
}
//Indique el responsable de la administración de la infraestructura
variable "responsable" {
  default = "Carlos Castrillón"
}

//Indique el cidrblock para la VPC, validar que el segmento seleccionado no se use en otra cuenta
//ejemplo default = "192.168.0.0/16"  se recomienta usar segmentos con mascara /16
variable "cidrblock" {
  default = "192.168.0.0/16"
}

locals{ 
  tags = {
    #type    = map(string)
    
      marca   = var.marca
      environment = var.environment
      responsable = var.responsable
    }
}

#esta variable account id solo se usa en la politica de KMS
variable "accountid" {
  default = "756915900426"
}

#esta variable s3_origin_id es nombre que le definimos al Origin name en Cloudfront
variable "s3_origin_id" {
  default = "s3-cloudops-bucket-webapp.carancas.com"
}