variable "namespace" {
  type        = string
  description = "The namespace this app will be deployed to"
}

variable "domains" {
  type        = list(string)
  description = "The domains this app will be available on. www is added automatically"
}

variable "app_version" {
  type        = string
  description = "Version to deploy (git hash)"
}

variable "staging" {
  type        = bool
  description = "Whether this is a staging environment"
  default     = false
}

variable "database_url" {
  type        = string
  description = "The connection string for the underlying Mongo DB database"
  sensitive   = true
}

variable "backup_bucket" {
  type        = string
  description = "AWS bucket name for backups. Can include subpath"
  default     = ""
}

variable "aws_key_id" {
  type        = string
  description = "AWS key ID for accessing the backup bucket"
  default     = ""
}

variable "aws_key_secret" {
  type        = string
  description = "AWS key secret for accessing the backup bucket"
  default     = ""
  sensitive   = true
}

variable "bugsnag_key" {
  type        = string
  description = "Key to access Buganag reporting API"
  default     = ""
}
