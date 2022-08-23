resource "aws_ssm_parameter" "secret" {
  name        = "/IaC_CloupOps/RDS/password/master"
  description = "Pass RDS IaC_CloudOps"
  type        = "SecureString"
  value       = var.database_master_password

  tags = merge({Name = join("-",tolist(["bastion", var.marca, var.environment]))},local.tags)
}