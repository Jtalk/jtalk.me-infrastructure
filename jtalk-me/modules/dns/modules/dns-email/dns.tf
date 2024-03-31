// Email values are not configurable since half of them
// (DKIM & DMARC) depend on the value of the domain,
// and string manipulation/replacement is not possible 
// for input variables.
// We keep the other half hard-coded as in not to 
// create expectations of Email DNS being configurable.

resource "cloudflare_record" "mx" {
  zone_id  = var.zone_id
  name     = var.root_domain
  type     = "MX"
  value    = "mx.runbox.com"
  priority = 10
}

resource "cloudflare_record" "spf" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "TXT"
  value   = "v=spf1 redirect=spf.runbox.com"
}

resource "cloudflare_record" "dkim" {
  count   = 2
  zone_id = var.zone_id
  name    = "selector${count.index + 1}._domainkey"
  type    = "CNAME"
  value   = "selector${count.index + 1}-${replace(var.root_domain, ".", "-")}.domainkey.runbox.com"
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=quarantine; ruf=mailto:me+dmarc-ruf@${var.root_domain}; fo=1; adkim=s; aspf=s"
}
