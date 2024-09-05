variable "region" {
  description = "AWS Region Name"
  type        = string
}

variable "ubuntu_ami_id" {
  description = "AMI ID of Image (Depends on region)"
  type        = string
}

variable "vpc_id" {
  description = "Default VPC ID"
  type        = string
}
