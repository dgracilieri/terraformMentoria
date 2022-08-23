#-------------------------
# EC2 Server
#-------------------------

variable "aws_ec2_pro_pub_01" {
  description = "Server, Env: PRO"
  type        = map
}

variable "aws_sg_ec2_pro_pub_01" {
  description = "Security group for Server, Env: PRO "
  type        = map
}

variable "aws_sr_ec2_pro_pub_01_internet_to_80" {
  description = "Access from Internet to port 80"
  type        = map
}

