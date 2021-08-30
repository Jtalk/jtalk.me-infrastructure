resource "random_password" "app_secret" {
  length  = 64
  special = false
}
