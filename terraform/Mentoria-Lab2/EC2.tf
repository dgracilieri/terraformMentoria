#Instancia bastion para el ambiente

resource "aws_instance" "ec2bastion" {
  depends_on            = [aws_security_group.publicsgr, aws_subnet.subnets, aws_s3_bucket_object.script]
  #ami                   = "ami-090fa75af13c156b4" #Amazon Linux https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html?icmpid=docs_ec2_console
  ami                   = "ami-052efd3df9dad4825" #Ubuntu 22
  #ami                   = "ami-08d4ac5b634553e16" #Ubuntu 20
  instance_type         = "t2.micro"
  key_name              = "keypair_candrescastrillon"
  vpc_security_group_ids       = [aws_security_group.publicsgr.id]
  subnet_id             = aws_subnet.subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.profile_to_ec2.name}"

    lifecycle {
      prevent_destroy = false
    }
 user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt  install w3m -y
sudo apt  install awscli -y
aws s3 cp s3://s3-cloudops-bucket-webapp.carancas.com-files/script_ubuntu.sh .
sudo chmod +x script_ubuntu.sh
sudo sh script_ubuntu.sh
EOF

    tags = merge({Name = join("-",tolist(["bastion-base", var.marca, var.environment]))},local.tags)
}
