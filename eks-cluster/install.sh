#!/bin/bash

# Function to check if Terraform is installed
check_terraform_installed() {
  if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform to proceed."
    exit 1
  fi
}

# Initialize and apply Terraform configuration
terraform_apply() {
  terraform init && terraform apply --auto-approve
}

# Check if Terraform is installed and apply configuration
check_terraform_installed
terraform_apply
