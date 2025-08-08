resource "helm_release" "vault" {
  name       = "vault"
  chart      = "vault"
  repository = "https://helm.releases.hashicorp.com"
  namespace  = "vault"
  version    = var.vault_version

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}