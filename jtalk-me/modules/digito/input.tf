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
