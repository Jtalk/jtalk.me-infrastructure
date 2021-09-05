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
      updated_at
    ]
  }

  node_pool {
    name       = "pool-large"
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
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

  atomic  = true
  timeout = 300

  cleanup_on_fail = true
  max_history     = 2
}
