output "name_servers" {
  value = merge(
    { for zone in module.dns_zone : zone.root_domain => zone.name_servers }
  )
}
