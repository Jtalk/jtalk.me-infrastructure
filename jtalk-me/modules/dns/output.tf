output "cloudflare_zone" {
  value = cloudflare_zone.root
}

output "name_servers" {
  value = cloudflare_zone.root.name_servers
}

output "root_ipv4" {
  value       = var.root_ipv4
  description = "IP of the cluster to set up DNS for"
}

output "root_ipv6" {
  value       = var.root_ipv6
  description = "IP v6 of the cluster to set up DNS for"
}

output "root_domain" {
  value       = var.root_domain
  description = "The domain to set up DNS for"
}

output "cloud_ipv4" {
  value       = var.cloud_ipv4
  description = "The IP v4 of the private cloud instance"
}

output "cloud_ipv6" {
  value       = var.cloud_ipv6
  description = "The IP v6 of the private cloud instance"
}

output "apps_enabled" {
  value       = var.apps_enabled
  description = "Add application-specific domains to this zone (e.g. staging)"
}

output "email_enabled" {
  value       = var.email_enabled
  description = "Add MX and the relevant entries to the domain records"
}
