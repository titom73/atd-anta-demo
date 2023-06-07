# Provision VM in GCP

Deploy pre-configured VM in Google GCP

> This page assume you have installed terraform and configured it to use GCP

## Variables

- `gcp_auth_file`: Authentication file provided by Google Cloud Platform. (Good [documentation](https://linuxhint.com/terraform_google_cloud_platform/) to get it)
- `gcp_project_id`: Your Goolge Project ID
- `public_key_path`: (__Mandatory__) Path to the SSH public key to use for SSH connection to the VM.
- `private_key_path`: (__Mandatory__) Path to the SSH private key to use provisioning the VM from your laptop.
- `gcp_region`: Region where the VM will be configured. (default: `europe-west-9`)
- `gcp_az`: AZ where the VM will be configured. (default: `europe-west-9a`)
- `instance_type`: Size of the VM running Containerlab. (default: `e2-standard-8`)
- `vm_name`: Name of the VM and VPC to configure in GCP.
- `network_subnet_cidr`: Subnet IP address to create in VPC.

A generic `tfvars` is part of this folder as a baseline.

## Outputs

Module provides some output informations:

- `gcp_region`: Which region VM is running
- `instance_public_ip`: Public IP address of the VM
- `ssh_connection`: Command to run to connect to the VM using SSH

## Local provisioner

Local provisioner is all set in script [`deploy.sh`](../deploy.sh) where you at have to change Arista API key

```bash
echo '*** intalling cEOS image'
eos-download --image cEOS --version 4.27.3F --import_docker --token <PLEASE-CHANGE-ME-BEFORE-USING-IT>
```

This provisioner is launched one the VM is setup and ready to be used.
