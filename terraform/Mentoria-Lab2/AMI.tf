# --- Use for AMI from EC2 ---
# resource "aws_ami_from_instance" "carancas-ami" {
#   depends_on = [aws_instance.ec2bastion]
#   name               = "tf-carancas-ami"
#   source_instance_id = aws_instance.ec2bastion.id
#   tags = merge({Name = join("-",tolist(["AMI-Bastion", var.marca, var.environment]))},local.tags)

# }