resource "random_password" "app_secret" {
  length  = 256
  special = false
}
