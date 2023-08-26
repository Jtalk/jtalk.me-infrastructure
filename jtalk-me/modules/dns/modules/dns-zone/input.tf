variable "cloudflare_account_id" {
  type        = string
  description = "Account ID to create the Zone in"
}

variable "root_domain" {
  type        = string
  description = "The root domain for the Zone"
}
