resource "random_password" "db_master_pass" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db-pass" {
  name = "db-pass-${random_id.id.hex}"
}

resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id = aws_secretsmanager_secret.db-pass.id
  secret_string = jsonencode(
    {
      username = aws_db_instance.mysql.username
      password = aws_db_instance.mysql.password
      engine   = "mysql"
      host     = aws_db_instance.mysql.endpoint
    }
  )
}

resource "aws_db_subnet_group" "rdssubgrp" {
  name       = "rdssubnetgrp"
  subnet_ids = aws_subnet.subnets[*].id  
}

resource "aws_db_instance" "mysql" {
  allocated_storage       = 20
  engine                 = "mysql"
  engine_version         = "8.0.28"
  identifier             = "rdsmysql"
  instance_class         = "db.t3.micro"
  db_name                = "rds_cloudops"
  username               = "admin"
  password               = random_password.db_master_pass.result
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rdssgr.id]
  db_subnet_group_name   = aws_db_subnet_group.rdssubgrp.name
  publicly_accessible    = true
  port                   = 3306
}