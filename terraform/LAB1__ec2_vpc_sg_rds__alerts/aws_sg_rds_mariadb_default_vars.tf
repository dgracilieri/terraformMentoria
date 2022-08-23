#-------------------------
# SECURITY - Default group
#-------------------------

variable "aws_sg_rds_mariadb_default" {
  description = "Default Security Group for all Maria DB instances"
  type        = map
}

variable "aws_sr_rds_mariadb_default_internet_to_db_port" {
  description = "Access from Instances to DB port"
  type        = map
}
