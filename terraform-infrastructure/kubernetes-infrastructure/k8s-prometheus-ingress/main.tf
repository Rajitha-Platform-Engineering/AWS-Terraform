resource "kubernetes_ingress_v1" "main" {
  metadata {
    name      = "k8s-prometheus-ingress"
    namespace = "prometheus"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.k8s_prometheus_ingress_url
      http {
        path {
          backend {
            service {
              name = "prometheus-kube-prometheus-prometheus"
              port {
                number = 9090
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      secret_name = "k8s-prometheus-tls"
      hosts       = [var.k8s_prometheus_ingress_url]
    }
  }
}