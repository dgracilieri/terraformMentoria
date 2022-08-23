#----------------------
# AWS Internet Gateway
#----------------------

#Create an Internet GW
module "aws_internet_gw" {
  source = "./modules/aws/network/internet_gateway"
  vpc_id = module.aws_network_vpc.id
  name   = var.aws_internet_gw_name
}