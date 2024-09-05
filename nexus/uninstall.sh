#!/bin/bash

# This script is intended to remove the infrastructure set up by install.sh and delete the associated key pair.

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# Check if Terraform is installed
if command_exists terraform; then
    echo "Terraform is installed."
else
    echo "Terraform is not installed. Please install Terraform to continue."
    exit 1
fi

# Your key definitions
LOCAL_KEY_PATH="./nexus"
PUBLIC_KEY_PATH="$LOCAL_KEY_PATH.pub" # Assuming the public key has .pub extension

# Check if public key exists
if [ -f "$PUBLIC_KEY_PATH" ]; then
    echo "Public key exists, proceeding with Terraform destruction."

    # Destroy Terraform managed infrastructure
    echo "Destroying Terraform managed infrastructure..."
    terraform destroy -auto-approve && rm terraform.tfvars
else
    echo "Public key does not exist. Terraform destruction is not necessary."
    exit 1
fi

rm inventory.ini

# Delete local key pair
if [ -f "$LOCAL_KEY_PATH" ]; then
    echo "Deleting key pair..."
    rm -f $LOCAL_KEY_PATH
    rm -f $PUBLIC_KEY_PATH
    echo "Key pair deleted."
else
    echo "Key pair not found, skipping deletion."
fi

echo "Infrastructure removal complete."
