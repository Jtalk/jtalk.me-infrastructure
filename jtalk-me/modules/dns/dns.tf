resource "cloudflare_zone" "root" {
  zone   = var.root_domain
  paused = false
  plan   = "free"
  type   = "full"
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = cloudflare_zone.root.id
  settings {
    ssl = "strict"
  }
}

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.root.id
  name    = cloudflare_zone.root.zone
  type    = "A"
  value   = var.root_ip
  proxied = true
}

resource "cloudflare_record" "caa" {
  zone_id = cloudflare_zone.root.id
  name    = cloudflare_zone.root.zone
  type    = "CAA"
  data = {
    flags = "0"
    value = "letsencrypt.org"
    tag   = "issue"
  }
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.root.id
  name    = "www"
  type    = "CNAME"
  value   = cloudflare_zone.root.zone
  proxied = true
}

resource "cloudflare_record" "digito" {
  zone_id = cloudflare_zone.root.id
  name    = "digito"
  type    = "CNAME"
  value   = cloudflare_zone.root.zone
  proxied = true
}

resource "cloudflare_record" "staging" {
  zone_id = cloudflare_zone.root.id
  name    = "staging"
  type    = "CNAME"
  value   = cloudflare_zone.root.zone
  proxied = true
}

/*********************************************
******************* CLOUD ********************
*********************************************/

resource "cloudflare_record" "cloud" {
  zone_id = cloudflare_zone.root.id
  name    = "cloud"
  type    = "A"
  value   = var.cloud_ipv4
  proxied = true
}

resource "cloudflare_record" "cloud_ipv6" {
  count   = length(var.cloud_ipv6) == 0 ? 0 : 1
  zone_id = cloudflare_zone.root.id
  name    = "cloud"
  type    = "AAAA"
  value   = var.cloud_ipv6
  proxied = true
}

/*********************************************
******************* EMAIL ********************
*********************************************/

// Email values are not configurable since half of them
// (DKIM & DMARC) depend on the value of the domain,
// and string manipulation/replacement is not possible 
// for input variables.
// We keep the other half hard-coded as in not to 
// create expectations of Email DNS being configurable.

resource "cloudflare_record" "mx" {
  zone_id  = cloudflare_zone.root.id
  name     = cloudflare_zone.root.zone
  type     = "MX"
  value    = "mx.runbox.com"
  priority = 10
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.root.id
  name    = cloudflare_zone.root.zone
  type    = "TXT"
  value   = "v=spf1 redirect=spf.runbox.com"
}

resource "cloudflare_record" "dkim" {
  count   = 2
  zone_id = cloudflare_zone.root.id
  name    = "selector${count.index + 1}._domainkey"
  type    = "CNAME"
  value   = "selector${count.index + 1}-${replace(cloudflare_zone.root.zone, ".", "-")}.domainkey.runbox.com"
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = cloudflare_zone.root.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=quarantine; rua=mailto:me+dmarc-rua@${cloudflare_zone.root.zone}; ruf=mailto:me+dmarc-ruf@${cloudflare_zone.root.zone}; fo=1; adkim=s; aspf=s"
}

resource "cloudflare_record" "smtp_tls_rpt" {
  zone_id = cloudflare_zone.root.id
  name    = "_smtp._tls"
  type    = "TXT"
  value   = "v=TLSRPTv1; rua=mailto:me+smtp-tls-rpt@${cloudflare_zone.root.zone}"
}
