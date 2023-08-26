resource "cloudflare_record" "root" {
  zone_id = var.zone_id
  name    = "www"
  type    = "CNAME"
  value   = var.cloud_cname
  proxied = true
}

resource "cloudflare_record" "redirect_root" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "CNAME"
  value   = var.cloud_cname
  proxied = true
}

resource "cloudflare_page_rule" "redirect_to_www" {
  zone_id  = var.zone_id
  target   = "${var.root_domain}/*"
  priority = 2

  actions {
    forwarding_url {
      url         = "https://www.${var.root_domain}/$1"
      status_code = 302
    }
  }
}
