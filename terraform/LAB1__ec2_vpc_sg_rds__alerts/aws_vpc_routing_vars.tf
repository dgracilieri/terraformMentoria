#-----------------------------------------
# ROUTING
#-----------------------------------------

variable "aws_main_route_table_name" {
  description = "Main VPC route table"
}

variable "aws_internet_route" {
  description = "Internet route"
  type        = map
}

variable "aws_private_route_table_za_name" {
  description = "VPC route table for private SN in zone A"
}

variable "aws_private_route_table_zb_name" {
  description = "VPC route table for private SN in zone B"
}