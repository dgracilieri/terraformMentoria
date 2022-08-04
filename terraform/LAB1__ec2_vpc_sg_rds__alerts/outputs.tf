#output "Public_IP_EC2_Instance" {
#  description ="Public_IP_EC2_Instance"
#  value = module.ec2.aws_instance.project-iac.public_ip
#}

#output "vpc_id" {
#  description = "El ID de la VPC es:"
#  value = module.vpc.vpc01.id
#}

#output "vpc_arn" {
#  description = "El ARN de la VPC es:"
#  value       = module.vpc.vpc_arn
#}