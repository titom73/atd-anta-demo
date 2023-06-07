variable "vm_name" {
  type        = string
  description = "Name of VM"
}

variable "instance_type" {
  type        = string
  description = "EC2 VM size"
}

variable "aws_region" {
  type        = string
  description = "Region to use to deploy stack"
}

variable "availability_zone" {
  type        = string
  description = "AZ to use to deploy stack"
}

variable "public_key_path" {
  type        = string
  description = "Path to public key to deploy in EC2 instance"
}

variable "private_key_path" {
  type        = string
  description = "Path to private key to deploy in EC2 instance"
}

variable "username" {
  default     = "ubuntu"
  type        = string
  description = "VM user"
}
