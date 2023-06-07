module "webserver" {
    source = "git::https://github.com/titom73/terraform-containerlab-vm.git//aws-containerlab-vm/"

    private_key_path    = var.private_key_path
    public_key_path     = var.public_key_path
    aws_region          = var.aws_region
    availability_zone   = var.availability_zone
    instance_type       = var.instance_type
    vm_name             = var.vm_name
    username                = var.username
}