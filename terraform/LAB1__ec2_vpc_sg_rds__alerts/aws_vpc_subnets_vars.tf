# ---------------------------------------------------
# SUBNETS
# ---------------------------------------------------

#Zone: A, Env: PRO, Type: PUBLIC, Code: 10
variable "aws_sn_za_pro_pub_10" {
  description = "Zone: A, Env: PRO, Type: PUBLIC, Code: 10"
  type        = map
}
#Zone: A, Env: PRO, Type: PRIVATE, Code: 20
variable "aws_sn_za_pro_pri_20" {
  description = "Zone: A, Env: PRO, Type: PRIVATE, Code: 20"
  type        = map
}

#Zone: B, Env: PRO, Type: PUBLIC, Code: 30
variable "aws_sn_zb_pro_pub_30" {
  description = "Zone: B, Env: PRO, Type: PUBLIC, Code: 30"
  type        = map
}
#Zone: B, Env: PRO, Type: PRIVATE, Code: 40
variable "aws_sn_zb_pro_pri_40" {
  description = "Zone: B, Env: PRO, Type: PRIVATE, Code: 40"
  type        = map
}
