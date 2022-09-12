# --- Use for AMI from EC2 ---
# resource "aws_launch_template" "config_template" {
#   depends_on = [aws_ami_from_instance.carancas-ami]
#   name_prefix   = "config_template_ami"
#   image_id      = aws_ami_from_instance.carancas-ami.id
#   instance_type = "t2.micro"
#   key_name              = "keypair_candrescastrillon"
#   vpc_security_group_ids       = [aws_security_group.publicsgr.id]
#   tags = {
#       Name = "Bastion-Clone"
#     }
# }


resource "aws_launch_template" "config_template" {
  name_prefix   = "config_template_ami"
  image_id      = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  key_name              = "keypair_candrescastrillon"
  vpc_security_group_ids       = [aws_security_group.publicsgr.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.profile_to_ec2.name
  }
  tags = {
      Name = "Bastion-Clone"
    }
  user_data = filebase64("${path.module}/user_data.sh")
}

resource "aws_autoscaling_group" "asg_carancas" {
  name               = "asg_carancas"
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2
  vpc_zone_identifier = aws_subnet.subnets[*].id

  launch_template {
    id      = aws_launch_template.config_template.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.tg-instances-carancas.arn ]
  tag {
    key                 = "Name"
    value               = "Clon-Bastion"
    propagate_at_launch = true
  }

}