resource "cloudflare_zone" "jtalk_me" {
  zone   = "jtalk.me"
  paused = false
  plan   = "free"
  type   = "full"
}

/*********************************************
******************** WEB *********************
*********************************************/

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = cloudflare_zone.jtalk_me.zone
  type    = "A"
  value   = local.cluster_ip
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "www"
  type    = "CNAME"
  value   = cloudflare_zone.jtalk_me.zone
  proxied = true
}

resource "cloudflare_record" "digito" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "digito"
  type    = "CNAME"
  value   = cloudflare_zone.jtalk_me.zone
  proxied = true
}

resource "cloudflare_record" "staging" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "staging"
  type    = "CNAME"
  value   = cloudflare_zone.jtalk_me.zone
  proxied = true
}

/*********************************************
******************* CLOUD ********************
*********************************************/

resource "cloudflare_record" "cloud" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "cloud"
  type    = "A"
  value   = var.cloud_ipv4
  proxied = true
}

resource "cloudflare_record" "cloud_ipv6" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "cloud"
  type    = "AAAA"
  value   = var.cloud_ipv6
  proxied = true
}

/*********************************************
******************* EMAIL ********************
*********************************************/

resource "cloudflare_record" "mx" {
  zone_id  = cloudflare_zone.jtalk_me.id
  name     = cloudflare_zone.jtalk_me.zone
  type     = "MX"
  value    = var.mail_mx
  priority = 10
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = cloudflare_zone.jtalk_me.zone
  type    = "TXT"
  value   = var.mail_spf
}

resource "cloudflare_record" "dkim" {
  count   = length(var.mail_dkim)
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "selector${count.index + 1}._domainkey"
  type    = "CNAME"
  value   = var.mail_dkim[count.index]
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = cloudflare_zone.jtalk_me.id
  name    = "_dmarc"
  type    = "TXT"
  value   = var.mail_dmarc
}
