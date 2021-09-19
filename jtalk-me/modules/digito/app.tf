resource "helm_release" "digito" {
  name       = "jtalk-digito"
  repository = "https://jtalk.github.io/digito/helm"
  chart      = "jtalk-digito"
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

  lifecycle {
    prevent_destroy = true
  }
}
