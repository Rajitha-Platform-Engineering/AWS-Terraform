resource "kubernetes_ingress_v1" "main" {
  metadata {
    name      = "k8s-vault-ingress"
    namespace = "vault"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.k8s_vault_ingress_url
      http {
        path {
          backend {
            service {
              name = "vault-ui"
              port {
                number = 8200
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      secret_name = "k8s-vault-tls"
      hosts       = [var.k8s_vault_ingress_url]
    }
  }
}