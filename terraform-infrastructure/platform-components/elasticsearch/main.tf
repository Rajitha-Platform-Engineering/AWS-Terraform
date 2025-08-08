resource "helm_release" "elasticsearch" {
  name             = "elasticsearch"
  namespace        = "elasticsearch"
  create_namespace = true
  repository       = "https://helm.elastic.co"
  chart            = "elasticsearch"
  version          = var.elasticsearch_version #"8.10.2"

  values = [
    file("${path.module}/values.yaml"),
    yamlencode({
      secret = {
        enabled  = true
        password = var.elasticsearch_password
      }
      image    = var.elasticsearch_image
      imageTag = var.elasticsearch_image_tag
    })
  ]

}