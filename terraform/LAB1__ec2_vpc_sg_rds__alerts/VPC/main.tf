#VPC
resource "aws_vpc" "vpc01" {
  cidr_block = var.cidrblock
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = var.tags
}


#Subnets
resource "aws_subnet" "subnets" {
  count                 = length(local.subnets)
  vpc_id = aws_vpc.vpc01.id
  cidr_block = local.subnets[count.index]
  availability_zone = var.azones[count.index]
  tags = merge(
      {
      "Name" = "${var.subnames[count.index]}"
      },
    var.tags)
}
 
#Igw and Natgw 
resource "aws_internet_gateway" "igw01" {
  vpc_id = aws_vpc.vpc01.id
  tags = merge(
      {
      "Name" = "${var.marca},${"Igw"}"
    },
  var.tags)
}

resource "aws_eip" "nateip" {
  depends_on            = [aws_internet_gateway.igw01]
  vpc      = true
  tags = merge(
      {
      "Name" = "${var.marca},${"NatEip"}"
    },
  var.tags)
}

resource "aws_nat_gateway" "servicesgw" {
  depends_on            = [aws_internet_gateway.igw01, aws_subnet.subnets]
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.subnets.0.id
 tags = merge(
      {
      "Name" = "${var.marca},${"Nat"}"
    },
  var.tags)
}
