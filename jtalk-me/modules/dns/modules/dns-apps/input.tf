variable "root_ipv4" {
  type        = string
  description = "IP of the cluster to set up DNS for"
}

variable "root_ipv6" {
  type        = string
  description = "IPv6 of the cluster to set up DNS for"
  default     = ""
}

variable "root_domain" {
  type        = string
  description = "The domain to set up DNS for"
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID to set this up in"
}
