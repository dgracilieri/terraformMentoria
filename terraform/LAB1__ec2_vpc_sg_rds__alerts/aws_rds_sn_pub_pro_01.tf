#----------------------
# SUBNET for RDS
#----------------------

  #----------------------
  # PRO
  #----------------------
  module "aws_rds_sn_pub_pro_01" {
    source      = "./modules/aws/rds/subnet"
    name        = var.aws_rds_sn_pub_pro_01["name"]
    description = var.aws_rds_sn_pub_pro_01["description"]

    # Add 2 PRIVATE Subnets from two availability zones
    subnet_ids  = [module.aws_sn_za_pro_pub_10.id, module.aws_sn_zb_pro_pub_30.id]
    # Add 1 PRIVATE Subnets from two availability zones
    #subnet_ids  = [module.aws_sn_za_pro_pub_10.id]
  }