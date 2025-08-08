terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "1.24.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path            = "~/.kube/config"
    host                   = data.aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.main.token
  }
}

provider "kubernetes" {
  config_path            = "~/.kube/config"
  host                   = data.aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.main.token
}