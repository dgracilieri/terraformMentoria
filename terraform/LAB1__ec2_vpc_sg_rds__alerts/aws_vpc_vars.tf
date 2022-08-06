#-----------------------------------------
# VPC
#-----------------------------------------

variable "aws_vpc_block" {
  description = "Private IP block for the VPC in CIDR format"
}

variable "aws_vpc_tag_name" {
  description = "Name of the VPC"
}
