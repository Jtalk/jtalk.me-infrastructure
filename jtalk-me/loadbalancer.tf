data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = local.ingress_controller_name
    namespace = helm_release.ingress_nginx.namespace
  }
}

locals {
  loadbalancer_ip = data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.ip
  cluster_ip      = local.loadbalancer_ip
}
