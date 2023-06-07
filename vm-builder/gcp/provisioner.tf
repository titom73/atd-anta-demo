resource "null_resource" "vm_provisioner" {
  provisioner "remote-exec" {
    script          = "../deploy.sh"

    connection {
      type          = "ssh"
      host          = module.webserver.instance_public_ip
      user          = var.username
      private_key   = file(var.private_key_path)
    }
  }
}