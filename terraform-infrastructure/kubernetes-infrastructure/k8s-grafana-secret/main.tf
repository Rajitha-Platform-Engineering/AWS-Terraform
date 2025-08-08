resource "kubernetes_secret" "main" {
  metadata {
    name      = "grafana-cognito-secret"
    namespace = "prometheus"
  }

  data = {
    GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET = var.oauth_client_secret
  }

  type = "Opaque"
}
