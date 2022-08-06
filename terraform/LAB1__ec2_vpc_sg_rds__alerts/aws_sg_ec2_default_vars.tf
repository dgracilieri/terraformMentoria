#-------------------------
# SECURITY - Default group
#-------------------------

variable "aws_sg_ec2_default" {
  description = "Default Security Group for all instances, Env: PRO"
  type        = map
}

variable "aws_sr_ec2_default_internet_to_ssh" {
  description = "Access from Internet IP to SSH port"
  type        = map
}
