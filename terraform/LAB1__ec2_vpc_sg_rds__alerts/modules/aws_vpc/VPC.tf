module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc_CloupOps"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.0.10.0/24"]
  public_subnets  = ["10.0.20.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

