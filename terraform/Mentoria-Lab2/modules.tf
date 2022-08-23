module "VPCouts" {
  source = "./VPC"
  marca = var.marca
  responsable = var.responsable
  environment = var.environment
  cidrblock = var.cidrblock
  tags = local.tags
}