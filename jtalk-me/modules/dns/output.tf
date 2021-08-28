output "cloudflare_zone" {
  value = cloudflare_zone.root
}

output "name_servers" {
  value = cloudflare_zone.root.name_servers
}

output "root_ip" {
  value       = var.root_ip
  description = "IP of the cluster to set up DNS for"
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
