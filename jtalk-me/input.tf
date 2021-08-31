variable "atlas_org_id" {
  type        = string
  description = "ID of the existing MongoDB Atlas organisation"
}

variable "domains" {
  type        = list(string)
  description = "Domains to set up DNS for"
}

variable "cloud_ipv4" {
  description = "An IPv4 address of the cloud instance (not managed by terraform)"
}

variable "cloud_ipv6" {
  description = "An IPv6 address of the cloud instance (not managed by terraform)"
}

variable "acme_email" {
  description = "An email to which Letsencrypt will send notifications"
}

variable "acme_key_base64" {
  description = "The secret key used for domain signing requests with Letsencrypt"
}

variable "jtalkme_bugsnag_key" {
  type        = string
  description = "A key for our UI error reporting service (Bugsnag)"
}

variable "jtalkme_version" {
  type        = string
  description = "Version (git hash) of the jtalk.me website to deploy"
}

variable "jtalkme_staging_version" {
  type        = string
  description = "Version (git hash) of the jtalk.me website to deploy"
}

variable "digito_version" {
  type        = string
  description = "Version (git hash) of the digito.jtalk.me website to deploy"
}
