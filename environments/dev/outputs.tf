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