#Definición de rutas necesarias para las subnets

#esta route table enruta el trafico hacia internet desde la subred publica 
# por medio del InternetGateway

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.vpc01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw01.id
  }
  tags = merge({Name = "${join("-",tolist(["RT", "Public", var.marca, var.environment]))}"},var.tags)
}

resource "aws_route_table_association" "publicrtas" {
  count = 2
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = aws_route_table.publicrt.id
}
