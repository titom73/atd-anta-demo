# Provision VM in AWS

Deploy pre-configured VM in Google AWS

> This page assume you have installed terraform and configured it to use AWS

## Variables

- `public_key_path`: Path to the SSH public key to use for SSH connection to the VM.
- `private_key_path`: Path to the SSH private key to use provisioning the VM from your laptop.
- `project`: Name of the project (default: `Containerlab`)
- `cidr_block`: IP range to use to configure VPC. (default: `10.0.0.0/16`)
- `network_subnet_cidr` Subnet allocated in `cidr_block` and used to connect VM. (default: `10.1.0.0/24`)
- `instance_type`: Size of the VM running Containerlab. (default: `t2.micro`)
- `aws_region`: In which region to run the topology. (default: `us-east-1`)
- `availability_zone`: Availability zone configured for the stack. (default: `us-east-1a`)
- `username`: User configured in the VM for running preprovisioning. (default: `ubuntu`)

A generic `tfvars` is part of this folder as a baseline.

## Outputs

Module provides some output informations:

- `AWS_region`: Which region VM is running
- `instance_public_ip`: Public IP address of the VM
- `ssh_connection`: Command to run to connect to the VM using SSH

## Local provisioner

Local provisioner is all set in script [`deploy.sh`](../deploy.sh) where you at have to change Arista API key

```bash
echo '*** intalling cEOS image'
eos-download --image cEOS --version 4.27.3F --import_docker --token <PLEASE-CHANGE-ME-BEFORE-USING-IT>
```

This provisioner is launched one the VM is setup and ready to be used.
