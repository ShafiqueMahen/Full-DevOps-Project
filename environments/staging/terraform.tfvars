# Environment
environment = "Stag2"

# Region
aws_region = "eu-west-2"

# VPC tfvars
vpc_cidr_block = "10.2.0.0/16"

vpc_availability_zones = ["eu-west-2a", "eu-west-2b"]

vpc_public_subnets = ["10.2.101.0/24", "10.2.102.0/24"]

vpc_private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]

# Web tfvars
instance_type = "t2.micro"

key_name = "TF-Generated-Key"