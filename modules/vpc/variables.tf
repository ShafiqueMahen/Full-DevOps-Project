# General variables
variable "environment" {
    description = "Environment"
    type = string
    default = "Dev"
}

variable "vpc_cidr_block" {
    description = "The CIDR block used by the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_availability_zones" {
    description = "VPC Availability Zones"
    type = list(string)
    default = ["eu-west-2a", "eu-west-2b"]
}

variable "vpc_public_subnets" {
    description = "VPC Public Subnets"
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}