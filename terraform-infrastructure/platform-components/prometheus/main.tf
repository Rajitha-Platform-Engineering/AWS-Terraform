resource "helm_release" "prometheus" {
  name             = "prometheus"
  namespace        = "prometheus"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = var.prometheus_version
  create_namespace = true

  set {
    name  = "prometheusOperator.createCustomResource"
    value = "true"
  }

  values = [
    file("${path.module}/values.yaml")
  ]
}