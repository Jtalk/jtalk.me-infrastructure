output "name_servers" {
  value = merge(
    { for dns in module.dns : dns.root_domain => dns.name_servers },
    { (module.dns_cloud.root_domain) : module.dns_cloud.name_servers }
  )
}
