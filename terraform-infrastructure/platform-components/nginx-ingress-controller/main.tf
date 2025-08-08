resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx-controller"
  namespace        = "nginx-ingress"
  create_namespace = true
  version          = var.nginx_version
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "controller.autoscaling.minReplicas"
    value = "2"
  }

  set {
    name  = "controller.autoscaling.maxReplicas"
    value = "5"
  }

  set {
    name  = "controller.autoscaling.targetCPUUtilizationPercentage"
    value = "80"
  }

}

