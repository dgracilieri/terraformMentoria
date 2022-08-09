#------------------------
# MAIN
#------------------------

is_production = false


#------------------------
# PROVIDERS
#------------------------

  # DEFAULT AWS
  #is_production = false
  provider_default_aws_profile    = "personal"
  provider_default_aws_region     = "us-east-1" 
  #provider_default_aws_account_id = [""]
  provider_default_aws_shared_credentials_file = "~/.aws/credentials"
  provider_default_aws_key_file = "~/keys/aws/keypair_candrescastrillon.pem"


#------------------------
# VPC - https://www.site24x7.com/tools/ipv4-subnetcalculator.html
#------------------------

  aws_vpc_tag_name  = "acme-vpc"
  aws_vpc_block     = "192.168.0.0/18" #192.168.0.1 - 192.168.63.254

#------------------------
# SUBNETS
#------------------------

  #------------------------
  # For EC2 instances 
  #------------------------

    #Zone: A, Env: PRO, Type: PUBLIC, Code: 10
    aws_sn_za_pro_pub_10={
      cidr   ="192.168.10.0/28" #192.168.10.1 - 192.168.10.14
      name   ="acme-sn-za-pro-pub-10"
      az     ="us-east-1a"
      public = "true"
    }

    #Zone: A, Env: PRO, Type: PRIVATE, Code: 20
    aws_sn_za_pro_pri_20={
      cidr   = "192.168.20.0/28" #192.168.20.1 - 192.168.20.14
      name   = "acme-sn-za-pro-pri-20"
      az     = "us-east-1a"
      public = "false"
    }

    #Zone: B, Env: PRO, Type: PUBLIC, Code: 30
    aws_sn_zb_pro_pub_30={
      cidr   = "192.168.30.0/28" #192.168.30.1 - 192.168.30.14
      name   = "acme-sn-zb-pro-pub-30"
      az     = "us-east-1b"
      public = "false"
    }

    #Zone: B, Env: PRO, Type: PRIVATE, Code: 40
    aws_sn_zb_pro_pri_40={
      cidr   = "192.168.40.0/28" #192.168.40.1 - 192.168.40.14
      name   = "acme-sn-zb-pro-pri-40"
      az     = "us-east-1b"
      public = "false"
    }



    #------------------------
    # For RDS instances
    #------------------------
    aws_rds_sn_pub_pro_01 = {
      name        = "acme-rds-sn-pub-pro-01"
      description = "acme-RDS-SN-pub-PRO-01"

      #See aws_rds_sn_pro.tf for subnet_ids
      #subnet_ids  = ${module.aws_sn_za_pro_pub_32.id},${module.aws_sn_zb_pro_pub_36.id
    }


#------------------------
# VPC ROUTING
#------------------------

aws_main_route_table_name = "acme-rt-pub-main"
aws_internet_gw_name = "acme-igw-pub"
aws_internet_route = {
  name = "acme-ir"
  destination_cidr_block = "0.0.0.0/0"
}
aws_private_route_table_za_name = "acme-rt-pri-za"
aws_private_route_table_zb_name = "acme-rt-pri-zb"



#------------------------
# SECURITY
#------------------------

  #------------------------
  # Default EC2
  #------------------------
  aws_sg_ec2_default = {
    sec_name        = "acme-sg-ec2-def"
    sec_description = "acme - Default Security Group - Env: PRO"
    allow_all_outbound = true #Allow all traffic
  }
    #------------------------
    # Allow SSH from my Internet IP to ...
    #------------------------
    aws_sr_ec2_default_internet_to_ssh = {
      type              = "ingress"
      from_port         = "22"
      to_port           = "22"
      protocol          = "tcp"
      cidr_blocks       = "" #data.external.whatismyip.result["internet_ip"]}/32"
      description       = "Access from Internet to SSH port"
    } 

    #------------------------
    # Default RDS
    #------------------------
    aws_sg_rds_mariadb_default = {
      sec_name        = "acme-sg-rds-mariadb-def"
      sec_description = "acme - Default Security Group RDS MariaDB"
      allow_all_outbound = true #Allow all traffic
    }
      #------------------------
      # Allow access from my Internet IP to DB port
      #------------------------
      aws_sr_rds_mariadb_default_internet_to_db_port = {
        type              = "ingress"
        from_port         = "3306"
        to_port           = "3306"
        protocol          = "tcp"
        cidr_blocks       = "" #data.external.whatismyip.result["internet_ip"]}/32"
        description       = "Access from My Internet IP to DB port"
      }



#------------------------
# RDS INSTANCES
#------------------------

  #------------------------
  # MariaDB PRO 01
  #------------------------
  aws_rds_mariadb_pro_pub_01 = {
    identifier              = "acme-rds-mariadb-pro-pub-01"
    allocated_storage       = 20 #GB
    storage_type            = "gp2"
    final_snapshot_id       = "acme-rds-mariadb-pro-pub-01-final"
    skip_final_snapshot     = false
    engine                  = "mariadb"
    engine_version          = "10.6.7"
    instance_class          = "db.t2.micro"
    password                = "RDSacmePROdb55" #change now or use variable
    username                = "acmeRDSPROdb01" #Start with a letter. Only numbers, letters, and _ accepted, 1 to 16 characters long
    availability_zone       = "us-east-1a"
    backup_retention_period = 5
    #db_subnet_group_name   = See var aws_rds_sn_pro_01["name"]
    multi_az                = false
    vpc_security_group_ids  = ""
    parameter_group_name    = ""
    allow_major_version_up  = false
    publicly_accessible     = true
    tag_private_name        = "acme-rds-mariadb-pro-pub-01"
    tag_public_name         = "acme-rds-mariadb-pro-pub-01"
    tag_app                 = "mariadb"
    tag_app_id              = "mariadb-01"
    tag_os                  = "rds"
    tags_environment        = "pro"
    tag_cost_center         = "acme-permanent"
  }

  #------------------------
  # RDS Security Group
  #------------------------
  aws_sg_rds_mariadb_pro_pub_01 = {
    sec_name        = "acme-aws-sg-rds-mariadb-pro-pub-01"
    sec_description = "acme - MariaDb server access rules - Pub, Env: PRO"
    allow_all_outbound = false
  }
    #------------------------
    # Allow access from my Instances to DB port
    #------------------------
    aws_sr_rds_mariadb_pro_pub_01_instances_to_db_port = {
      type              = "ingress"
      from_port         = "3306"
      to_port           = "3306"
      protocol          = "tcp"
      #source_security_group_id module.aws_sec_group_ec2_default.id
      description       = "Access from Instances to DB port"
    }


#------------------------
# EC2 INSTANCES
#------------------------

    #------------------------
    # EC2
    #------------------------

  aws_ec2_pro_pub_01 = {
    name              = "acme-ec2-pro-pub-01"
    ami               = "ami-090fa75af13c156b4"
    instance_type     = "t2.micro"
    availability_zone = "us-east-1a"
    key_name          = "keypair_candrescastrillon"
    # vpc_security_group_ids = SEE TF file
    # subnet_id         = SEE TF file
    associate_public_ip_address = true #comment for priv

    root_block_device_size        = 8
    root_block_device_volume_type = "gp2"

    tag_private_name  = "acme-ec2-pro-pub-01"
    tag_Name          = "acme-ec2-pro-pub-01"
    tag_public_name   = "www"
    tag_app           = "linux"
    tag_app_id        = "linux-01"
    tag_os            = "linux"
    tag_os_id         = "linux"
    tags_environment  = "pro"
    tag_cost_center   = "acme-permanent"
    tags_volume       = "acme-ec2-pro-pub-01-root"

  }

  #------------------------
  # EC2 Security Group
  #------------------------
  aws_sg_ec2_pro_pub_01 = {
    sec_name        = "acme-sg-ec2-pro-pub-01"
    sec_description = "acme - Pub, Env: PRO, HTTP: 80, SSH: 22"
    allow_all_outbound = false
  }

  aws_sr_ec2_pro_pub_01_internet_to_80 = {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = "0.0.0.0/0"
    description       = "Access from Internet to port 80"
  }




/*
    #------------------------
    # Allow SSH from my Internet IP to ...
    #------------------------
    aws_sr_ec2_default_internet_to_ssh = {
      type              = "ingress"
      from_port         = "22"
      to_port           = "22"
      protocol          = "tcp"
      cidr_blocks       = "" #data.external.whatismyip.result["internet_ip"]}/32"
      description       = "Access from Internet to SSH port"
    }

      #------------------------
      # Allow access from my Internet IP to DB port
      #------------------------
      aws_sr_rds_mariadb_default_internet_to_db_port = {
        type              = "ingress"
        from_port         = "3306"
        to_port           = "3306"
        protocol          = "tcp"
        cidr_blocks       = "" #data.external.whatismyip.result["internet_ip"]}/32"
        description       = "Access from My Internet IP to DB port"
      }*/