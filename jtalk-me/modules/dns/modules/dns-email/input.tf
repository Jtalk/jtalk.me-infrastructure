variable "root_domain" {
  type        = string
  description = "The domain to set up DNS for"
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID to set this up in"
}
