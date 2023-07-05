output "vpc_id" {
    description = "The VPC ID"
    value = aws_vpc.main.id
}

output "cidr_block_vpc" {
    description = "The VPC CIDR Block"
    value = aws_vpc.main.cidr_block
}

output "azs" {
    description = "The AZs used in VPC"
    value = var.vpc_availability_zones
}
output "public_subnet_ids" {
    description = "The IDs of Public Subnets in VPC"
    value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
    description = "The IDs of Private Subnets in VPC"
    value = aws_subnet.private_subnets[*].id
}

output "internet_gateway_id" {
    description = "The ID of IGW in VPC"
    value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
    description = "The ID of NGW in VPC"
    value = aws_nat_gateway.ngw.id
}