# Module for creating a Virtual Private Cloud (VPC) in AWS
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.1"

  # VPC name
  name = "secureflow_vpc"

  # VPC CIDR block
  cidr = "10.0.0.0/16"

  # Availability Zones for private and public subnets
  azs = var.azs

  # CIDR blocks for private subnets
  private_subnets = var.private_subnets

  # CIDR blocks for public subnets
  public_subnets = var.public_subnets

  # Enable NAT Gateway for private subnets
  enable_nat_gateway = true

  # Use a single NAT Gateway for all private subnets
  single_nat_gateway = true

  # Use one NAT Gateway per Availability Zone
  one_nat_gateway_per_az = false

  # Enable DNS hostnames and support
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tags to apply to AWS resources created by the VPC module
  tags = {
    Environment = "Production"
  }
}
