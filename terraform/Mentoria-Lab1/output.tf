output "Public_IP_EC2_Instance" {
  value = aws_instance.ec2bastion.public_ip
}

output "Public_ENDPOINT_RDS" {
  value =  aws_db_instance.mysql.endpoint
}