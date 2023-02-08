output "ip_address" {
  value       = module.compute.ip_address
  description = "The IP address of the EC2 instance"
}

output "gophish_admin_domain" {
  value       = "${cloudflare_record.admin_a.name}.${var.zone}"
  description = "The full domain for the GoPhish admin interface"
}

output "gophish_web_domain" {
  value       = "${cloudflare_record.web_a.name}.${var.zone}"
  description = "The full domain for GoPhish websites"
}
