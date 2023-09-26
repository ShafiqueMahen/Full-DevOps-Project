# Terraform Web App on AWS using Best Practices (Terratest, Module & GitHub Actions CI/CD Pipeline)

## Project Overview

This project aims to provide a blueprint for creating a robust, scalable web server infrastructure on AWS using Terraform. It emphasizes:

- **Infrastructure as Code (IaC)**: Infrastructure components are defined as code using Terraform, ensuring consistency and repeatability.

- **Modular Design**: Terraform modules have been authored for key components, allowing for easy reuse and extensibility.

- **Testing with Terratest**: Rigorous testing is integral to this project. Terratest is used to validate the infrastructure, reducing the risk of issues in production.

- **Efficient CI/CD**: A GitHub Actions workflow automates updates and maintenance, ensuring the infrastructure stays reliable and up-to-date.

## Prerequisites

1. Configure AWS Credentials
2. Terraform and Go installed on local machine
3. Fork the repo and pull it down
4. Customise the Terraform variables in the appropriate `.tfvars` files.

## Guide

To test the modules:
1. Make sure you are in the test directory. `cd tests`.
2. `go test -v modules_test.go` - This command will use the Terratest file to check if the modules work and do what they're intended to do.

To manually provision the infrastructure:
1. Make sure you are in the right environment, example being: `cd environments/dev` should put you in the dev environment directory.
2. `terraform init` - This command will initialise a working directory containing Terraform configuration files with the required plugins mentioned.
3. `terraform validate` - This command will validate the syntax in these configuration files in the working directory.
4. `terraform plan` - This command will plan the infrastructure.
5. `terraform apply` - Once everything has been checked and you are happy with the planned infrastructure, you can go ahead and apply the configuration with this command. Once prompted to approve the infrastructure, type `yes` to proceed.
6. (OPTIONAL) `terraform destroy` - When happy to remove the provisioned infrastructure, use this command. Like the previous command, when prompted type `yes` to proceed.

