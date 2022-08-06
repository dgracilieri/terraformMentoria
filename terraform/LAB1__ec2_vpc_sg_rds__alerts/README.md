#Laboratorio 1
##Definición

Construir IaC que incluya los servicios EC2, VPC, SG, RDS y le agreguemos métricas de monitoreo en Cloudwatch y generar alertamientos.


###Diagrama General
Este diagrama muestra los elementos principales de la infraestructura que será creada mediante Terraform:

- 1 VPC
- 4 sub-redes
- 4 grupos de seguridad
- 3 tablas de rutas
- 1 instancia EC2
- 1 Puerta de salida a Internet (gateway)
- 1 Grupo de sub-red de base de datos
- 1 Base de datos RDS MariaDB


##Estructura de Ficheros
Los ficheros de configuración de Terraform se utilizan para describir la infraestructura y asignar valores a las variables, la mayoría de los ejemplos de Internet utilizan un solo fichero o como mucho unos pocos para configurar toda la infraestructura.
###Tables
                    
Nombre  | Descripción
------------- | -------------
modules	|	Directorio con los módulos de Terraform
aws_ds_aws_ami.tf	|	Fuente de datos para obtener el ID de los últimos AMI para el sistema operativo seleccionado
aws_ec2_pro_wp.tf	|	Servidor WordPress, grupos de seguridad asociados, registro en DNS (Route 53)
aws_ec2_pro_wp_vars.tf	|	Variables del servidor WordPress
aws_internet_gateway.tf	|	Internet Gateway
aws_internet_gateway_vars.tf	|	Variables del Internet Gateway
aws_rds_pro_mariadb_01.tf	|	RDS MariaDB y grupos de seguridad asociados
aws_rds_pro_mariadb_01_vars.tf	|	RDS MariaDB variables
aws_rds_sn_pro.tf	|	RDS subred
aws_rds_sn_pro_vars.tf	|	Variables de RDS subred
aws_route53.tf	|	Route 53 (DNS)
aws_route53_vars.tf	|	Variables de Route 53 (DNS)
aws_sec_group_ec2_default.tf	|	Grupos de seguridad asignados por defecto a todas las instancias EC2
aws_sec_group_ec2_default_vars.tf	|	Variables grupos de seguridad EC2 por defecto
aws_sec_group_rds_mariadb_default.tf	|	Grupos de seguridad asignados por defecto a todas las instancias RDS MariaDB
aws_sec_group_rds_mariadb_default_vars.tf	|	Variables por defecto para los grupos de seguridad de RDS
aws_vpc_routing.tf	|	Tablas de rutas de las sub-redes
aws_vpc_routing_vars.tf	|	Variables para las tablas de rutas de las sub-redes
aws_vpc_subnets.tf	|	Sub-redes de VPC
aws_vpc_subnets_vars.tf	|	Variables sub-redes de VPC
aws_vpc.tf	|	VPC
aws_vpc_vars.tf	|	VPC variables
external_whatismyip.tf	|	Obtiene su IP pública de Internet para usarla en el firewall de AWS
provider_aws.tf	|	Define el proveedor AWS
provider_aws_vars.tf	|	Variables para la definición del proveedor AWS
terraform.tf	|	Define Terraform
terraform.tfvars	|	Valores para todas las variables del tutorial
terraform_vars.tf	|	Definición de todas las variables
whatismyip.sh	|	Script para obtener su IP pública de Internet para usarla en el firewall de AWS
.gitignore	|	Excluye ficheros y directorios del repositorio GIT
.terraform	|	Directorio de trabajo creado por Terraform
