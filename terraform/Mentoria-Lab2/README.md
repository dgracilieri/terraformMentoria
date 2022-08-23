Segundo reto basado en conocimientos adquiridos y nuevos agregando un nivel de complejidad del 40%.

Frontend : Cloudfront con un sitio desplegado en S3 ( El acceso a s3 solo sera por cloudfront ). WAF SQL Injection. 
Backend ( Privado ): ALB con ASG con EC2, RDS con Secret Manager con rotación de contraseña automatica.
Monitoreo: Registar access log de  s3 y cloudfront en otro bucket de S3.Crear tablero donde se muestren consultas.
Segundo tablero donde veamos ALB, EC2 y RDS.



Esta plantilla de terraform despliega un ambiente básico un bastion para el ambiente y una base de datos RDS publicos

Entre los componentes desplegados se encuentran:
- 1 VPC
- 2 subnets publicas para bastion y RDS
- 1 Bastion
- 1 RDS con parameter store

Por organización, el despliegue usa el  modulo para separar los recursos de la VPC. El resto de servicios que no tienen una definición extensa se han definido sin uso de módulos
