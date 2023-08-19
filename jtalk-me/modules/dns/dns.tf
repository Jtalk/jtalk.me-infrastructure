locals {
  all_domains = setunion(var.app_domains, var.email_domains, var.cloud_domains)
}

module "dns_zone" {
  for_each    = local.all_domains
  source      = "./modules/dns-zone"
  root_domain = each.key
}

module "apps_dns" {
  for_each = var.app_domains
  source   = "./modules/dns-apps"

  zone_id     = module.dns_zone[each.key].id
  root_ipv4   = var.root_ipv4
  root_ipv6   = var.root_ipv6
  root_domain = each.key
}

module "email_dns" {
  for_each = var.email_domains
  source   = "./modules/dns-email"

  zone_id     = module.dns_zone[each.key].id
  root_domain = each.key
}

module "cloud_dns" {
  for_each = var.cloud_domains
  source   = "./modules/dns-cloud"

  zone_id     = module.dns_zone[each.key].id
  root_domain = each.key
  cloud_cname = var.cloud_cname
}
