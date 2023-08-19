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
