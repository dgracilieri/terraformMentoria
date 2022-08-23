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
  tags = merge({Name = join("-",tolist(["Sgr", "Services", var.marca, var.environment]))},var.tags)
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
  description              = ""
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
  tags = merge({Name = join("-",tolist(["Sgr", "RDS", var.marca, var.environment]))},var.tags)
  
}


# Grupo de seguridad para subred publica
resource "aws_security_group" "publicsgr" {
  name        = "PublicSgr"
  description = "Public Security Group"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "6"
    cidr_blocks = [format("%s/%s",data.external.whatismyip.result["internet_ip"],32)]
    description = "My IP PUB - Bastion access"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = merge({Name = join("-",tolist(["Sgr", "Public", var.marca, var.environment]))},var.tags)
}