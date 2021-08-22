
variable "existing_cluster_ip_temp" {
  description = "Store existing cluster's IP while we're migrating to the terraform-managed one"
}

variable "cloud_ipv4" {
  description = "An IPv4 address of the cloud instance (not managed by terraform)"
}

variable "cloud_ipv6" {
  description = "An IPv6 address of the cloud instance (not managed by terraform)"
}

variable "mail_mx" {
  type        = string
  description = "MX server for domain mail"
}

variable "mail_spf" {
  type        = string
  description = "SPF values for domain mail"
}

variable "mail_dkim" {
  type        = list(string)
  description = "DKIM values for domain mail"
}

variable "mail_dmarc" {
  type        = string
  description = "DMARC value for domain mail"
}
