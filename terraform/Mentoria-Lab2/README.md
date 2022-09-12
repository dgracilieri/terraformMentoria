# Example code for setting up password rotation for RDS

# Segundo reto basado en conocimientos adquiridos y nuevos agregando un nivel de complejidad del 40%.

Frontend : Cloudfront con un sitio desplegado en S3 ( El acceso a s3 solo sera por cloudfront ). WAF SQL Injection. 
Backend ( Privado ): ALB con ASG con EC2, RDS con Secret Manager con rotación de contraseña automatica.
Monitoreo: Registar access log de  s3 y cloudfront en otro bucket de S3.Crear tablero donde se muestren consultas.
Segundo tablero donde veamos ALB, EC2 y RDS.

## Requirements

* AWS account
* Terraform + AWS CLI configured

## Deploy

* ```terraform init```
* ```terraform apply```

## Usage

* Go to the Secrets Manager service and inspect the secret
* You can rotate it with the button

## Cleanup

* ```terraform destroy```
