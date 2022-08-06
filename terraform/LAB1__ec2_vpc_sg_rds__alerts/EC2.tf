resource "aws_instance" "project-iac" {
  #depends_on            = ["aws_security_group.publicsgr", "aws_subnet.subnets"]
  ami                   = "ami-090fa75af13c156b4"
  instance_type         = "t2.micro"
  key_name              = "EC2 - Amazon Linux"
  #vpc_security_group_ids       = ["${aws_security_group.publicsgr.id}"]
  #subnet_id             = "${aws_subnet.subnets.id}"
  
   tags = {
    Terraform = "true"
    Environment = "dev"
  }
  }
