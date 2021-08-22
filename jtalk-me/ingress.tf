resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  namespace        = "ingress-nginx"
  create_namespace = true

  atomic  = true
  timeout = 300

  cleanup_on_fail = true
  max_history     = 2

  set {
    name  = "controller.admissionWebhooks.timeoutSeconds"
    value = 29
  }

  set {
    name  = "fullnameOverride"
    value = "ingress-nginx"
  }

  set {
    name  = "controller.name"
    value = "controller"
  }
}

locals {
  ingress_name              = jsondecode(helm_release.ingress_nginx.metadata.0.values)["fullnameOverride"]
  ingress_controller_suffix = jsondecode(helm_release.ingress_nginx.metadata.0.values)["controller"]["name"]
  ingress_controller_name   = "${local.ingress_name}-${local.ingress_controller_suffix}"
}
