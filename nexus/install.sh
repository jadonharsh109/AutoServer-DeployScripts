#!/bin/bash

# Exit on any error
set -e

# Function to check if a command exists
command_exists () {
    command -v "$1" >/dev/null 2>&1
}

# Check if Terraform is installed
if command_exists terraform; then
    echo "Terraform is installed."
else
    echo >&2 "Terraform is not installed. Please install Terraform to continue."
    exit 1
fi

# Check if Ansible is installed
if command_exists ansible; then
    echo "Ansible is installed."
else
    echo >&2 "Ansible is not installed. Please install Ansible to continue."
    exit 1
fi

# Specify your key path and key name
LOCAL_KEY_PATH="./nexus"
KEY_NAME="nexus"

# Check for existing keys and create them if they don't exist
if [ ! -f "$LOCAL_KEY_PATH" ]; then
  if ssh-keygen -t rsa -b 2048 -f $LOCAL_KEY_PATH -q -N ""; then
    echo "SSH key successfully created."
  else
    echo >&2 "Failed to create SSH key."
    exit 1
  fi
else
  echo "Key already exists, skipping key generation."
fi


# Function to initialize Terraform and apply configuration
run_terraform() {
    echo "Initializing Terraform..."
    if ! terraform init; then
        echo >&2 "Failed to initialize Terraform."
        exit 1
    fi

    echo "Applying Terraform configuration..."
    if ! terraform apply -auto-approve; then
        echo >&2 "Failed to apply Terraform configuration."
        exit 1
    fi
}

# Function to update Ansible inventory
update_inventory() {
    echo "Updating Ansible inventory..."
    local nexus_ip
    nexus_ip=$(terraform output -raw nexus_public_ip)
    if [ -z "$nexus_ip" ]; then
        echo >&2 "Failed to retrieve nexus server IP address."
        exit 1
    else
        echo "nexus Server IP: $nexus_ip"
    fi

    cat > inventory.ini <<EOF
[nexus]
nexus_server ansible_host=$nexus_ip ansible_user=ubuntu ansible_ssh_private_key_file=$LOCAL_KEY_PATH
EOF
}

# Function to run Ansible playbook
run_ansible() {
    echo "Running Ansible playbook to install nexus..."
    if ! ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini nexus_setup.yml; then
        echo >&2 "Failed to run Ansible playbook."
        exit 1
    fi
    echo "Installation complete."
}

# Execute the functions
run_terraform
# Adjust this sleep as necessary or implement a more precise wait mechanism.
echo "Waiting for EC2 instances to initialize..."
sleep 30
update_inventory
run_ansible

# Inform the user about how to access nexus
export nexus_ip=$(terraform output -raw nexus_public_ip)
echo "You can access nexus at: http://$nexus_ip:8081"
echo "You can access nexus vm by ssh"
echo "ssh -i $KEY_NAME ubuntu@$nexus_ip"
