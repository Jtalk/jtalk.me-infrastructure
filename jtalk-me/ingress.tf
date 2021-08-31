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

locals {
  cert_manager_ns    = "cert-manager"
  cert_issuer_secret = "acme-key"
}
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  namespace        = local.cert_manager_ns
  create_namespace = true

  atomic  = true
  timeout = 60

  cleanup_on_fail = true
  max_history     = 2

  set {
    name  = "installCRDs"
    value = true
  }
}

resource "kubernetes_secret" "acme_key" {
  metadata {
    name      = local.cert_issuer_secret
    namespace = local.cert_manager_ns
  }

  binary_data = {
    "tls.key" = var.acme_key_base64
  }
}

resource "kubernetes_manifest" "acme_cluster_issuer" {
  depends_on = [
    helm_release.cert_manager,
    kubernetes_secret.acme_key,
  ]
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt"
    }
    "spec" = {
      "acme" = {
        "email"  = var.acme_email
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "privateKeySecretRef" = {
          "name" = local.cert_issuer_secret
        }
        "solvers" = [{
          "http01" = {
            "ingress" = {
              "class" = "nginx"
            }
          }
        }]
      }
    }
  }
}
