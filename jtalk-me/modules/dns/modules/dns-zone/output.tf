output "id" {
  value       = cloudflare_zone.root.id
  description = "Zone ID of the created zone"
}

output "root_domain" {
  value = var.root_domain
}

output "name_servers" {
  value       = cloudflare_zone.root.name_servers
  description = "Name servers of the created zone"
}
