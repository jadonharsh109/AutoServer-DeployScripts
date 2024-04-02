variable "region" {
  description = "AWS Region Name"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID of Image (Depends on region)"
  type        = string
  default     = "ami-080e1f13689e07408"
}
