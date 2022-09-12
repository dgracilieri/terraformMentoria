#VPC
resource "aws_vpc" "vpc01" {
  cidr_block = var.cidrblock
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge({Name = "${join("-",tolist(["VPC", var.marca, var.environment]))}"})
}

#Subnets
resource "aws_subnet" "subnets" {
  count                 = length(local.subnets)
  vpc_id = aws_vpc.vpc01.id
  cidr_block = local.subnets[count.index]
  availability_zone = var.azones[count.index]
  map_public_ip_on_launch = true
  tags = merge({Name = "${join("-",tolist(["Subnet",var.subnames[count.index], var.environment]))}"})
}


#Igw
resource "aws_internet_gateway" "igw01" {
  vpc_id = aws_vpc.vpc01.id
  tags = merge({Name = "${join("-",tolist(["Igw",var.marca, var.environment]))}"})
}









#-----------------------------------------
# Obtain current Public Internet IP https://www.itwonderlab.com/es/ip-publica-firewall-aws-terraform/
#-----------------------------------------

data "external" "whatismyip" {
  program = ["/bin/bash" , "${path.module}/whatismyip.sh"]
}



#Grupo de seguridad para servicios 
resource "aws_security_group" "servicessgr" {
  name        = "ServicesSgr"
  description = "Services Security Group"
  vpc_id      = aws_vpc.vpc01.id
  tags = merge({Name = join("-",tolist(["Sgr", "Services", var.marca, var.environment]))})
}

resource "aws_security_group_rule" "services_inbound1" {
  description              = "Bastion-services access"
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.servicessgr.id
  cidr_blocks = [join("", [local.PrivIPBastion,"/32"])]
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "services_outbound1" {
  description              = "RDS-services access"
  from_port                = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.servicessgr.id
  to_port                  = 0
  type                     = "egress"
}


# Grupo de seguridad para rds

resource "aws_security_group" "rdssgr" {
  name        = "RDSSgr"
  description = "RDS Security Group"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [join("", [local.PrivIPBastion,"/32"])] 
    description = "Bastion-RDS access"
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s",data.external.whatismyip.result["internet_ip"],32)]
    description = "My IP PUB - RDS access"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = merge({Name = join("-",tolist(["Sgr", "RDS", var.marca, var.environment]))})
  
}


# Grupo de seguridad para subred publica y permitimos todo el flujo de datos entre los componentes
resource "aws_security_group" "publicsgr" {
  name        = "PublicSgr"
  description = "Public Security Group"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
    description = "My IP PUB - Bastion access"
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access 80 From All - Bastion access"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = merge({Name = join("-",tolist(["Sgr", "Public", var.marca, var.environment]))})
}








#Definición de rutas necesarias para las subnets

#esta route table enruta el trafico hacia internet desde la subred publica 
# por medio del InternetGateway

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.vpc01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw01.id
  }
  tags = merge({Name = "${join("-",tolist(["RT", "Public", var.marca, var.environment]))}"})
}

resource "aws_route_table_association" "publicrtas" {
  count = 2
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = aws_route_table.publicrt.id
}


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