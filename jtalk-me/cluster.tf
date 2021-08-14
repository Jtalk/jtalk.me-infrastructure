resource "digitalocean_kubernetes_cluster" "main-cluster" {
  name          = "k8s-jtalk"
  region        = "lon1"
  version       = "1.21.2-do.2"
  auto_upgrade  = true
  surge_upgrade = true

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      version
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
