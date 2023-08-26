resource "digitalocean_kubernetes_cluster" "main_cluster" {
  name          = "k8s-jtalk"
  region        = "lon1"
  version       = "1.21.2-do.2"
  auto_upgrade  = true
  surge_upgrade = true

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      version,
    ]
  }

  node_pool {
    name       = "pool-large"
    size       = "s-2vcpu-4gb"
    auto_scale = false
    node_count = 1
  }

  maintenance_policy {
    start_time = "01:00"
    day        = "any"
  }
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  version    = "4.5.3"

  namespace        = "metrics-server"
  create_namespace = true

  atomic  = true
  timeout = 60

  cleanup_on_fail = true
  max_history     = 2

  set {
    name  = "extraArgs.kubelet-preferred-address-types"
    value = "InternalIP"
  }

  set {
    name  = "apiService.create"
    value = true
  }
}
