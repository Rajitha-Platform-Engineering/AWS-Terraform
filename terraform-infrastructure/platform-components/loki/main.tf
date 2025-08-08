resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "loki"
  chart            = "loki-stack"
  repository       = "https://grafana.github.io/helm-charts"
  version          = var.loki_version
  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}
