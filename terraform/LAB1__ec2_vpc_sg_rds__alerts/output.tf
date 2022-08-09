output "Public_Name_EC2_Instance" {
  value = var.aws_ec2_pro_pub_01.name
}

/* output "ARN_EC2_Instance V2" {
  value = var.aws_ec2_pro_pub_01.arn
}  */

/* output "ARN_EC2_Instance_V1" {
  value = aws_instance.default.name
}  */

/* output "ARN_EC2_Instance_V1" {
  value = module.aws_ec2_pro_pub_01.aws_instance.default.name
}  */

/* output "ARN_EC2_Instance_V1" {
  value = ["${aws_instance.default.*.public_ip}"]
}   */