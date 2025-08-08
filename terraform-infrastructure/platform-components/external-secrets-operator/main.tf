resource "helm_release" "external_secrets_operator" {
  name       = "external-secrets"
  chart      = "external-secrets"
  repository = "https://charts.external-secrets.io"
  namespace  = "eso"
  version    = var.eso_version

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]

}