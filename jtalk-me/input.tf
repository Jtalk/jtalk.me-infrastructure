variable "atlas_org_id" {
  type        = string
  description = "ID of the existing MongoDB Atlas organisation"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Account ID to create the DNS Zone in"
}

variable "app_domains" {
  type        = set(string)
  description = "Domains used for Apps (K8s)"
}

variable "cloud_domains" {
  type        = set(string)
  description = "Domains used for Cloud (File Storage)"
}

variable "email_domains" {
  type        = set(string)
  description = "Domains used for Email"
}

variable "cloud_cname" {
  description = "CNAME target to set up for the Cloud instance"
}

variable "acme_email" {
  description = "An email to which Letsencrypt will send notifications"
}

variable "acme_key_base64" {
  sensitive   = true
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
