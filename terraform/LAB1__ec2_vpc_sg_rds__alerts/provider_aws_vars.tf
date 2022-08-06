#-----------------------------------------
# Default provider: AWS
#-----------------------------------------

variable "provider_default_aws_profile" {
  description = "AWS profile name as set in the shared credentials file"
  default     = "none"
}

variable "provider_default_aws_region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "provider_default_aws_account_id" {
  description = "List of allowed, white listed, AWS account IDs"
  default     = []
}

variable "provider_default_aws_shared_credentials_file" {
  description = "This is the path to the shared credentials file"
}

variable "provider_default_aws_key_file" {
  description = "Location of PEM file for SSH"
}
