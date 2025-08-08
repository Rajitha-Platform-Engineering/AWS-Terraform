resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  version          = var.cert_manager_version
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

}

resource "helm_release" "cluster_issuer" {
  name       = "cert-issuer"
  repository = path.module
  chart      = "cert-issuer"

  depends_on = [helm_release.cert_manager]
}