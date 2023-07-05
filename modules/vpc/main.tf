resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block

    tags = {
      Name = "${var.environment}-VPC"
      Environment = var.environment
    }
}

resource "aws_subnet" "public_subnets" {
    count = length(var.vpc_public_subnets)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.vpc_public_subnets, count.index)
    availability_zone = element(var.vpc_availability_zones, count.index)
}

resource "aws_subnet" "private_subnets" {
    count = length(var.vpc_private_subnets)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.vpc_private_subnets, count.index)
    availability_zone = element(var.vpc_availability_zones, count.index)
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

resource "aws_eip" "eip" {
    vpc = true
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.eip.id
    connectivity_type = "public"
    subnet_id = aws_subnet.public_subnets[0].id
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

}

resource "aws_route_table" "private_rt" {
    count = length(aws_subnet.private_subnets)
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ngw.id
    }

}

resource "aws_route_table_association" "public_subnet_assoc" {
    count = length(aws_subnet.public_subnets)
    subnet_id = aws_subnet.public_subnets[count.index].id
    route_table_id = element(aws_route_table.public_rt.*.id, count.index)
}

resource "aws_route_table_association" "private_subnet_assoc" {
    count = length(aws_subnet.private_subnets)
    subnet_id = aws_subnet.private_subnets[count.index].id
    route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}