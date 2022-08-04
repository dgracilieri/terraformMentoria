# Grupo de seguridad para subred publica
resource "aws_security_group" "publicsgr" {
  name        = "PublicSgr"
  description = "Public Security Group"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "6"
    cidr_blocks = ["190.131.230.18/32"]
    description = "IP publica Pragma"
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "6"
    cidr_blocks = [local.publicblock01, local.publicblock02]
    description = "Selft Access"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
   tags = merge(
      {
      "Name" = "${var.marca},${"Sgr-Public"}"
    },
  var.tags)
}