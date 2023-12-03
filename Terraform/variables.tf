variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "ECS VPC CIDR"
  type        = string
  default     = "172.16.0.0/16"
}

variable "public_subnet_one" {
  description = "Public Subnet One"
  default     = "172.16.0.0/24"
  type        = string
}

variable "public_subnet_two" {
  description = "Public Subnet Two"
  default     = "172.16.1.0/24"
  type        = string
}

variable "instance_tenancy" {
  description = "Instance Tenancy"
  default     = "default"
  type        = string
}

variable "default_gateway" {
  description = "Default Gateway"
  default     = "0.0.0.0/0"
  type        = string
}