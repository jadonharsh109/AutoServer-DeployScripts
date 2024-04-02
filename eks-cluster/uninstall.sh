#!/bin/bash

# Function to check if Terraform is installed
check_terraform_installed() {
  if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Cannot proceed with the destruction."
    exit 1
  fi
}

# Initialize and destroy Terraform managed infrastructure
terraform_destroy() {
  echo "Destroying Terraform-managed infrastructure..."
  terraform init && terraform destroy --auto-approve
}

# Check if Terraform is installed and destroy configuration
check_terraform_installed
terraform_destroy
