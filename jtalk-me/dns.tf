module "dns" {
  source = "./modules/dns"

  app_domains   = var.app_domains
  cloud_domains = var.cloud_domains
  email_domains = var.email_domains

  root_ipv4   = local.cluster_ip
  cloud_cname = var.cloud_cname
}
