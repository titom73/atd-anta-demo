module "webserver" {
    source = "git::https://github.com/titom73/terraform-containerlab-vm.git//gcp-containerlab-vm/"

    gcp_auth_file            = var.gcp_auth_file
    gcp_project_id          = var.gcp_project_id
    gcp_region              = var.gcp_region
    gcp_az                  = var.gcp_az
    vm_name                 = var.vm_name
    instance_type           = var.instance_type
    network_subnet_cidr     = var.network_subnet_cidr
    public_key_path         = var.public_key_path
    private_key_path        = var.private_key_path
    username                = var.username
}
