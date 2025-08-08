resource "kubernetes_ingress_v1" "main" {
  metadata {
    name      = "k8s-grafana-ingress"
    namespace = "prometheus"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.k8s_grafana_ingress_url
      http {
        path {
          backend {
            service {
              name = "prometheus-grafana"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      secret_name = "k8s-grafana-tls"
      hosts       = [var.k8s_grafana_ingress_url]
    }
  }
}