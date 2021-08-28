module "dns" {
  for_each    = toset(var.domains)
  source      = "./modules/dns"
  root_ip     = local.cluster_ip
  root_domain = each.key
  cloud_ipv4  = var.cloud_ipv4
  cloud_ipv6  = var.cloud_ipv6
}
