module "vpc" {
  source = "../../modules/vpc"
  # Environment taken into account
  environment = var.environment
  # Use desired VPC inputs or defaults 
  vpc_cidr_block = var.vpc_cidr_block
  vpc_availability_zones = var.vpc_availability_zones
  vpc_public_subnets = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets
}

module "web" {
  source = "../../modules/web"
  # Wait for VPC to be created before making the Web server(s)
  depends_on = [module.vpc]

  # Use outputs from VPC Module as inputs for Web Module
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  
  # Add other necessary inputs
  environment = var.environment
  instance_type = var.instance_type
  key_name = var.key_name

}