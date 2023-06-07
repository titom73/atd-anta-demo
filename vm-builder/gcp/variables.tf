### GCP Authnetication

# GCP authentication file
variable "gcp_auth_file" {
  type          = string
  description   = "GCP authentication file"
}

variable "gcp_region" {
  default        = "eu-west-9"
  type           = string
  description    = "Region where the VM will be located"
}

variable "gcp_az" {
  default       = "eu-west-9a"
  type          = string
  description   = "Availability Zone for the VM"
}

variable "gcp_project_id" {
  type          = string
  description   = "The project field should be your personal project id. The project indicates the default GCP project all of your resources will be created in"
}

### Project variables

variable "vm_name" {
  default       = "containerlab"
  type          = string
  description   = "Name of the VM"
}

variable "instance_type" {
  default       = "e2-standard-8"
  type          = string
  description   = "Type of VM to provision"
}

variable "vm_image_path" {
  default       = ""
  type          = string
  description   = "Path to installation image"
}

variable "network_subnet_cidr" {
  default       = "10.1.0.0/24"
  type          = string
  description   = "The CIDR for the network subnet"
}

variable "public_key_path" {
  type        = string
  description = "Path to public key to deploy in GCP instance"
}

variable "private_key_path" {
  type        = string
  description = "Path to private key to use to connect to GCP instance"
}

variable "username" {
  default     = "ubuntu"
  type        = string
  description = "VM user"
}