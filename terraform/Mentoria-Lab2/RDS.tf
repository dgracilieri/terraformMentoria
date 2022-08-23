resource "aws_db_instance" "mysql" {
  allocated_storage       = 20
  auto_minor_version_upgrade  = true
  backup_retention_period = 7
  backup_window           = "05:00-05:30"
  copy_tags_to_snapshot   = true
  db_subnet_group_name    = aws_db_subnet_group.rdssubgrp.id
  engine                  = "mysql"
  engine_version          = "8.0.28"
  identifier              = "rdsmysql"
  instance_class          = "db.t3.micro"
  maintenance_window      = "Sun:06:00-Sun:07:00"
  parameter_group_name    = "default.mysql8.0"
  db_name                  = "rds_cloudops"
  username                = "usrmysqlcloudops"
  password                = var.database_master_password //parameter store cifrado
  port                    = 3306
  publicly_accessible     = true
  skip_final_snapshot     = true
  vpc_security_group_ids  =  [module.VPCouts.rdssgrid]
  tags = merge({Name = join("-",tolist(["RDSMysql", var.marca, var.environment]))},local.tags)
}

resource "aws_db_subnet_group" "rdssubgrp" {
  name       = "rdssubnetgrp"
  subnet_ids = [module.VPCouts.subnetsid[0], module.VPCouts.subnetsid[1]]
  tags = merge({Name = join("-",tolist(["Subgrp", "RDS", var.marca, var.environment]))},local.tags)
}
