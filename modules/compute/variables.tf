variable "subnet_id" {
  type        = string
  description = "The subnet ID for deploying EC2 instances to"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID for deploying EC2 instances to"
}

variable "prefix" {
  type        = string
  description = "A prefix for all resources"
}

variable "cidr_block" {
  type        = string
  description = "The VPC CIDR block"
}

variable "access_cidrs" {
  type        = list(string)
  description = "The CIDR blocks to allow access from"
  default     = []
}
