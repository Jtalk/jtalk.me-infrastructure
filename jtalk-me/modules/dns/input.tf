variable "root_ipv4" {
  type        = string
  description = "IP of the cluster to set up DNS for"
}

variable "root_ipv6" {
  type        = string
  description = "IPv6 of the cluster to set up DNS for"
  default     = ""
}

variable "cloud_cname" {
  type        = string
  description = "CNAME target for the Cloud instance. Only CNAME cloud is supported"
}

variable "app_domains" {
  type        = set(string)
  description = "Domains to set up for Apps (facing K8s)"
}

variable "email_domains" {
  type        = set(string)
  description = "Domains to set up for Email (MX, SPF, etc)"
}

variable "cloud_domains" {
  type        = set(string)
  description = "Domains to set up for Cloud (File Storage)"
}
