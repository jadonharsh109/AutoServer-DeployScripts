# AutoServer-DeployScripts

Streamline your server setups with our comprehensive automation toolkit. By integrating Terraform, Ansible, and Shell scripts, this repository simplifies the process of provisioning and configuring servers. It's ideal for DevOps professionals and system admins who aim to implement Infrastructure as Code (IaC) practices with efficiency and reliability.

## Getting Started

These instructions will get your copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them?
- [Terraform](https://github.com/jadonharsh109/My-DevOps-Journey/blob/cf6b153e11b02e4b579f9f3764e976ca11badd05/DevOps%20CheatSheet/Vm's%20Provisioning%20Script/Installation%20-%20Terraform.txt)
- [Ansible](https://github.com/jadonharsh109/My-DevOps-Journey/blob/cf6b153e11b02e4b579f9f3764e976ca11badd05/DevOps%20CheatSheet/Vm's%20Provisioning%20Script/Installation%20-%20Ansible.txt)
- AWS CLI --> Install by running - ``` sudo apt install -y awscli``` and Configure by running - ``` aws configure ```.

### Deployment

1. Clone the repository:
   ```sh
   git clone https://github.com/jadonharsh109/AutoServer-DeployScripts.git
   
2. Navigate to the repository directory:
   ```sh
   cd AutoServer-DeployScripts
   
3. Create any Server Infrstructure using script:
   ```sh
   cd <Server_Name>
   chmod +x install.sh
   ./install.sh

### Clean Up

1. Delete any Server Infrstructure using script:
   ```sh
   cd <Server_Name>
   chmod +x uninstall.sh
   ./uninstall.sh

## Security
We take the security of our software seriously. If you find any security vulnerability, please send a report to jadonharsh109@gmail.com.

## Contributing
We encourage public contributions! Please review our contribution guidelines prior to submitting any pull requests.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.

## Contact
- Name: Harshvardhan Singh Jadon
- LinkedIn: [jadonharsh](https://www.linkedin.com/in/jadonharsh/)
- Email: jadonharsh109@gmail.com
- Project Link: https://github.com/jadonharsh109/AutoServer-DeployScripts
