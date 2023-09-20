# Global Input Variables
variable "environment" {
    description = "Environment"
    type = string
    default = "Prod"
}

variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

# VPC Specific Variables
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

# Web Specific Variables
variable "instance_type" {
  description = "Desired instance type for Web EC2 instance"
  default = "t2.micro"
}

variable "key_name" {
    description = "SSH Key Name"
    default = "TF-nginx-ec2-key-prod"
}