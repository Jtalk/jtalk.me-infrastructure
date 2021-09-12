module "dns" {
  for_each      = toset(var.domains)
  source        = "./modules/dns"
  root_ipv4     = local.cluster_ip
  root_domain   = each.key
  cloud_ipv4    = var.cloud_ipv4
  cloud_ipv6    = var.cloud_ipv6
  apps_enabled  = true
  email_enabled = true
}

module "dns_cloud" {
  source      = "./modules/dns"
  root_ipv4   = var.cloud_ipv4
  root_ipv6   = var.cloud_ipv6
  root_domain = var.cloud_domain
}
