resource "cloudflare_record" "caa" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "CAA"
  data {
    flags = "0"
    value = "letsencrypt.org"
    tag   = "issue"
  }
}

resource "cloudflare_record" "root" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "A"
  value   = var.root_ipv4
  proxied = true
}

resource "cloudflare_record" "root_ipv6" {
  count   = length(var.root_ipv6) == 0 ? 0 : 1
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "AAAA"
  value   = var.root_ipv6
  proxied = true
}

resource "cloudflare_record" "digito" {
  zone_id = var.zone_id
  name    = "digito"
  type    = "CNAME"
  value   = var.root_domain
  proxied = true
}

resource "cloudflare_record" "staging" {
  zone_id = var.zone_id
  name    = "staging"
  type    = "CNAME"
  value   = var.root_domain
  proxied = true
}
