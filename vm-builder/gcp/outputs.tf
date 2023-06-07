output "instance_public_ip" {
  description = "Public IP of GCP instance"
  value       = module.webserver.instance_public_ip
}

output "gcp_region" {
  description = "Region where VM is running on"
  value = var.gcp_az
}

output "ssh_connection" {
  description = "Connection information"
  value = "${module.webserver.ssh_connection}"
}