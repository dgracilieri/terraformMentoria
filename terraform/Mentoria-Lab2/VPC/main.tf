#VPC
resource "aws_vpc" "vpc01" {
  cidr_block = var.cidrblock
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge({Name = "${join("-",tolist(["VPC", var.marca, var.environment]))}"},var.tags)
}

#Subnets
resource "aws_subnet" "subnets" {
  count                 = length(local.subnets)
  vpc_id = aws_vpc.vpc01.id
  cidr_block = local.subnets[count.index]
  availability_zone = var.azones[count.index]
  tags = merge({Name = "${join("-",tolist([var.subnames[count.index], var.environment]))}"},var.tags)
}


#Igw and Natgw 
resource "aws_internet_gateway" "igw01" {
  vpc_id = aws_vpc.vpc01.id
  tags = merge({Name = "${join("-",tolist(["Igw",var.marca, var.environment]))}"},var.tags)
}
