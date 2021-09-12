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

variable "cloud_ipv4" {
  type        = string
  description = "The IP v4 of the private cloud instance"
  default     = ""
}

variable "cloud_ipv6" {
  type        = string
  description = "The IP v6 of the private cloud instance"
  default     = ""
}

variable "apps_enabled" {
  type        = bool
  description = "Add application-specific domains to this zone (e.g. staging)"
  default     = false
}

variable "email_enabled" {
  type        = bool
  description = "Add MX and the relevant entries to the domain records"
  default     = false
}
