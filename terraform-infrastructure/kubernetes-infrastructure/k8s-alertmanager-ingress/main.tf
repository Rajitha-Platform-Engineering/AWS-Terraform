resource "kubernetes_ingress_v1" "main" {
  metadata {
    name      = "k8s-alertmanager-ingress"
    namespace = "prometheus"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.k8s_alertmanager_ingress_url
      http {
        path {
          backend {
            service {
              name = "prometheus-kube-prometheus-alertmanager"
              port {
                number = 9093
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      secret_name = "k8s-alertmanager-tls"
      hosts       = [var.k8s_alertmanager_ingress_url]
    }
  }
}