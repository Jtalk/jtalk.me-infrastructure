resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  namespace        = "ingress-nginx"
  create_namespace = true

  atomic  = true
  timeout = 120

  cleanup_on_fail = true
  max_history     = 2

  set {
    name  = "controller.admissionWebhooks.timeoutSeconds"
    value = 29
  }
}
