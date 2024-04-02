variable "region" {
  description = "AWS Region Name"
  type        = string
  default     = "us-east-1"
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "List of Private Subnets"
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_subnets" {
  description = "List of Public Subnets"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
}
