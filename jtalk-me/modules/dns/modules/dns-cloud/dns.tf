resource "cloudflare_record" "root" {
  zone_id = var.zone_id
  name    = "www"
  type    = "CNAME"
  value   = var.cloud_cname
  proxied = false
}
