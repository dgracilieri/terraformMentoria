#Instancia bastion para el ambiente

resource "aws_instance" "ec2bastion" {
  depends_on            = [module.VPCouts.publicsgrid, module.VPCouts.subnetsid]
  ami                   = "ami-090fa75af13c156b4"
  instance_type         = "t2.micro"
  key_name              = "keypair_candrescastrillon"
  vpc_security_group_ids       = [module.VPCouts.publicsgrid]
  subnet_id             = module.VPCouts.subnetsid[0]
  private_ip            = module.VPCouts.PrivIPbastion
  associate_public_ip_address = true

    lifecycle {
      prevent_destroy = false
    }
  user_data = <<-EOF
		#!/bin/bash -xe
    yum update
    yum install mysql htop -y
    sleep 60; yes> /dev/null &
	EOF

  tags = merge({Name = join("-",tolist(["bastion", var.marca, var.environment]))},local.tags)
  }
  