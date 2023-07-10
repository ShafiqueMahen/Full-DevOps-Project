# General variables
variable "environment" {
    description = "Environment"
    type = string
    default = "Dev"
}
# Variables dependent on VPC module
variable "vpc_id" {
    description = "The VPC ID"
    default = ""
}

variable "public_subnet_ids" {
    description = "The IDs of Public Subnets in VPC"
    default = ""
}

variable "private_subnet_ids" {
    description = "The IDs of Private Subnets in VPC"
    default = ""
}

# Web specific input variables
variable "instance_type" {
  description = "Desired instance type for Web EC2 instance"
  type = string
  default = "t2.micro"
}

variable "key_name" {
    description = "SSH Key Name"
    type = string
    default = "TF-nginx-ec2-key"
}