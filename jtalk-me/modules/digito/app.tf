resource "helm_release" "digito" {
  name       = "jtalk-digito"
  repository = "https://jtalk.github.io/digito/helm"
  chart      = "jtalk-digito"
  version    = "1.0.0-${var.app_version}"

  namespace        = var.namespace
  create_namespace = true

  atomic        = true
  timeout       = 900
  wait_for_jobs = true

  cleanup_on_fail = true
  max_history     = 2

  values = [
    yamlencode({
      "domains" : var.domains
    })
  ]

  set {
    name  = "ui.deployment.image.version"
    value = var.app_version
  }

  set {
    name  = "api.deployment.image.version"
    value = var.app_version
  }

  lifecycle {
    prevent_destroy = true
  }
}
