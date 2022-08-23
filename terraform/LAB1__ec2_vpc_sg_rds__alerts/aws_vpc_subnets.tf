#-----------------------------------------
# Zones
#-----------------------------------------

#Zone: A, Env: PRO, Type: PUBLIC, Code: 10
module "aws_sn_za_pro_pub_10" {
  source = "./modules/aws/network/subnet"
  vpc_id = module.aws_network_vpc.id
  cidr   = var.aws_sn_za_pro_pub_10["cidr"]
  name   = var.aws_sn_za_pro_pub_10["name"]
  az     = var.aws_sn_za_pro_pub_10["az"]
  public = var.aws_sn_za_pro_pub_10["public"]
}

#Zone: A, Env: PRO, Type: PRIVATE, Code: 20
module "aws_sn_za_pro_pri_20" {
  source = "./modules/aws/network/subnet"
  vpc_id = module.aws_network_vpc.id
  cidr   = var.aws_sn_za_pro_pri_20["cidr"]
  name   = var.aws_sn_za_pro_pri_20["name"]
  az     = var.aws_sn_za_pro_pri_20["az"]
  public = var.aws_sn_za_pro_pri_20["public"]
}

#Zone: B, Env: PRO, Type: PUBLIC, Code: 30
module "aws_sn_zb_pro_pub_30" {
  source = "./modules/aws/network/subnet"
  vpc_id = module.aws_network_vpc.id
  cidr   = var.aws_sn_zb_pro_pub_30["cidr"]
  name   = var.aws_sn_zb_pro_pub_30["name"]
  az     = var.aws_sn_zb_pro_pub_30["az"]
  public = var.aws_sn_zb_pro_pub_30["public"]
}

#Zone: B, Env: PRO, Type: PRIVATE, Code: 40
module "aws_sn_zb_pro_pri_40" {
  source = "./modules/aws/network/subnet"
  vpc_id = module.aws_network_vpc.id
  cidr   = var.aws_sn_zb_pro_pri_40["cidr"]
  name   = var.aws_sn_zb_pro_pri_40["name"]
  az     = var.aws_sn_zb_pro_pri_40["az"]
  public = var.aws_sn_zb_pro_pri_40["public"]
}
