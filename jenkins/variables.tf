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

variable "key_name" {
  description = "EC2 Key Pair Name (Already Exist)"
  type        = string
  default     = "jenkins"
}
