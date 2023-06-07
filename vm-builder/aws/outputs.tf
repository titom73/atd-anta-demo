output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = "${module.webserver.instance_public_ip}"
}

output "ssh_connection" {
  description = "Connection information"
  value = "${module.webserver.ssh_connection}"
}

output "aws_region" {
  description = "Region where VM is running on"
  value = "${module.webserver.aws_region}"
}