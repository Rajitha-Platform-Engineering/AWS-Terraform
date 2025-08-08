resource "helm_release" "mysql" {
  name             = "mysql"
  namespace        = "mysql-db"
  create_namespace = true
  chart            = "mysql"
  repository       = "https://charts.bitnami.com/bitnami"
  version          = var.mysql_version

  values = [file("${path.module}/values.yaml")]

}