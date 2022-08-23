#-----------------------------------------
# Terraform defaults
#-----------------------------------------

# Configures the behavior of Terraform itself
# only allowed configurations within this block are required_version and backend.
# Detail: https://www.terraform.io/docs/configuration/terraform.html

#terraform {
#  required_version = "~> 0.12" #cannot contain interpolations. Means requiered version >= 0.12 and < 0.13
#}
#terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "4.17.1"
#    }
#  }
#}