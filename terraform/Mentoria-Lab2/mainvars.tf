# Esta plantilla de terraform despliega un ambiente en AWS
# El despliegue usa el modulo para separar los recursos de la VPC.

#Entre los componentes desplegados se encuentran:
# una VPC
# 2 subnets publicas para bastion y RDS
# bastion para el ambiente
# Base de datos RDS


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

#esta variable account id solo se usa en la politica de KMS
variable "database_master_password"{
  type = string
  description = "Escriba la contraseña para la instancia RDS"
  validation{
    condition = length(var.database_master_password) > 5
    error_message = "la contraseña para el RDS debe ser mayor a 5 caracteres."
  }
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