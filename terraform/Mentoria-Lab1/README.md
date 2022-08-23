Esta plantilla de terraform despliega un ambiente básico un bastion para el ambiente y una base de datos RDS publicos

Entre los componentes desplegados se encuentran:
- 1 VPC
- 2 subnets publicas para bastion y RDS
- 1 Bastion
- 1 RDS con parameter store

Por organización, el despliegue usa el  modulo para separar los recursos de la VPC. El resto de servicios que no tienen una definición extensa se han definido sin uso de módulos