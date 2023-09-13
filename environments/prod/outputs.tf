output "vpc_id" {
    description = "The VPC ID"
    value = module.vpc.vpc_id
}

output "cidr_block_vpc" {
    description = "The VPC CIDR Block"
    value = module.vpc.cidr_block_vpc
}

output "azs" {
    description = "The AZs used in VPC"
    value = module.vpc.azs
}
output "public_subnet_ids" {
    description = "The IDs of Public Subnets in VPC"
    value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
    description = "The IDs of Private Subnets in VPC"
    value = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
    description = "The ID of IGW in VPC"
    value = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
    description = "The ID of NGW in VPC"
    value = module.vpc.nat_gateway_id
}

# Web Output Variables
output "sg_alb_id" {
  description = "The ID of the ALB SG"
  value = module.web.alb_sg_id
}

output "sg_ec2_bastion_id" {
  description = "The ID of the Bastion EC2 SG"
  value = module.web.ec2_bastion_sg_id
}

output "ec2_web_sg_id" {
  description = "The ID of the web EC2 SG"
  value = module.web.alb_sg_id
}

output "ec2_bastion_public_ip" {
    description = "The Elastic IP assigned to the bastion EC2 instance"
    value = module.web.ec2_bastion_public_ip
}

output "ec2_bastion_private_ip" {
    description = "The Private IP of the bastion EC2 instance"
    value = module.web.ec2_bastion_private_ip
}

output "ec2_web_private_ip" {
    description = "The Private IP of the web EC2 instances"
    value = module.web.ec2_web_private_ip
}

output "alb_dns_name" {
    description = "The DNS name of the ALB"
    value = module.web.alb_dns
}