resource "helm_release" "jtalk_me" {
  name       = "jtalk-me"
  repository = "https://jtalk.github.io/home/helm"
  chart      = "jtalk-me"
  version    = "1.0.0-${var.app_version}"

  namespace        = var.namespace
  create_namespace = true

  atomic        = true
  timeout       = 60
  wait_for_jobs = true

  cleanup_on_fail = true
  max_history     = 2

  values = [
    yamlencode({
      "domains" : var.domains
    })
  ]

  set_sensitive {
    name  = "database.url"
    value = var.database_url
  }

  set {
    name  = "staging"
    value = var.staging
  }

  set {
    name  = "database.backup.aws.bucket"
    value = var.backup_bucket
  }

  set {
    name  = "database.backup.aws.key.id"
    value = var.aws_key_id
  }

  set_sensitive {
    name  = "database.backup.aws.key.secret"
    value = var.aws_key_secret
  }

  set {
    name  = "ui.bugsnag.key"
    value = var.bugsnag_key
  }

  set_sensitive {
    name  = "api.encryption.secret"
    value = random_password.app_secret.result
  }

  set {
    name  = "ui.deployment.image.version"
    value = var.app_version
  }

  set {
    name  = "api.deployment.image.version"
    value = var.app_version
  }

  set {
    name  = "database.migration.image.version"
    value = var.app_version
  }

  set {
    name  = "database.backup.image.version"
    value = var.app_version
  }

  lifecycle {
    prevent_destroy = true
  }
}
