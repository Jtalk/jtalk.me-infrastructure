variable "root_ip" {
  type        = string
  description = "IP of the cluster to set up DNS for"
}

variable "root_domain" {
  type        = string
  description = "The domain to set up DNS for"
}

variable "cloud_ipv4" {
  type        = string
  description = "The IP v4 of the private cloud instance"
}

variable "cloud_ipv6" {
  type        = string
  description = "The IP v6 of the private cloud instance"
  default     = ""
}
