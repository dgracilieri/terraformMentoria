/* output "Public_IP_EC2_Instance" {
  value = aws_instance.ec2bastion.public_ip
}

output "Public_ENDPOINT_RDS" {
  value =  aws_db_instance.mysql.endpoint
} */

# Imprime los archivos procesados hasta el momento
output "fileset-results" {
  value = fileset("./website-content/", "**/*")
}

# to get the Cloud front URL if doamin/alias is not configured
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

