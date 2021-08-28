variable "atlas_org_id" {
  type        = string
  description = "ID of the existing MongoDB Atlas organisation"
}

variable "existing_cluster_ip_temp" {
  description = "Store existing cluster's IP while we're migrating to the terraform-managed one"
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
