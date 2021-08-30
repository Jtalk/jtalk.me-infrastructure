output "name_servers" {
  value = { for dns in module.dns : dns.root_domain => dns.name_servers }
}
