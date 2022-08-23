#-----------------------------------------
# VPC
#-----------------------------------------

#Create a VPC
module "aws_network_vpc" {
  source           = "./modules/aws/network/vpc"
  aws_vpc_block    = var.aws_vpc_block
  aws_vpc_tag_name = var.aws_vpc_tag_name
}
