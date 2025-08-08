# Locals

locals {
  eks_vpc_id = module.aws_vpc.eks_vpc_id
  rds_vpc_id = module.aws_vpc.rds_vpc_id
}

# Data Sources
data "aws_eks_cluster" "main" {
  name = module.aws_eks_cluster.aws_eks_cluster_name

  depends_on = [module.aws_eks_cluster]
}

data "aws_eks_cluster_auth" "main" {
  name = data.aws_eks_cluster.main.name

}

# Kubernetes Resources - Prometheus Ingress
module "k8s-prometheus-ingress" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-prometheus-ingress"

  k8s_prometheus_ingress_url = var.k8s_prometheus_ingress_url

  depends_on = [module.prometheus]
}

# Kubernetes Resources - Grafana Ingress
module "k8s-grafana-ingress" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-grafana-ingress"

  k8s_grafana_ingress_url = var.k8s_grafana_ingress_url

  depends_on = [module.prometheus]
}

# Kubernetes Resources - Grafana Ingress
module "k8s-alertmanager-ingress" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-alertmanager-ingress"

  k8s_alertmanager_ingress_url = var.k8s_alertmanager_ingress_url

  depends_on = [module.prometheus]
}

# Kubernetes Resources - Vault Ingress
module "k8s-vault-ingress" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-vault-ingress"

  k8s_vault_ingress_url = var.k8s_vault_ingress_url

  depends_on = [module.hashicorp_vault_infrastructure]
}

# Kubernetes Resources - Prometheus AlertManager Configuration Secret
module "k8s-prometheus-secret" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-prometheus-secret"

  depends_on = [
    module.aws_eks_cluster,
    module.prometheus
  ]
}

# Kubernetes Resources - Grafana AWS Cognito Secret
module "k8s-grafana-secret" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-grafana-secret"

  oauth_client_secret = module.aws_cognito_user_pool_client.grafana_client_secret

  depends_on = [
    module.aws_eks_cluster,
    module.prometheus
  ]
}

# Kubernetes Resources - AlertManager Config
module "k8s-alertmanager-config" {
  source = "../terraform-infrastructure/kubernetes-infrastructure/k8s-alertmanager-config"

  depends_on = [
    module.prometheus
  ]
}

# Kubernetes Resources - Prometheus Alerts
resource "kubernetes_manifest" "prometheus-alerts" {
  manifest = yamldecode(file("${path.module}/../terraform-infrastructure/platform-components/prometheus/prometheus-rules/pod-down-alert.yaml"))

  depends_on = [
    module.aws_eks_cluster,
    module.prometheus
  ]
}

# Platform Services - Elasticsearch
module "elasticsearch" {
  source = "../terraform-infrastructure/platform-components/elasticsearch"

  elasticsearch_version   = var.elasticsearch_version
  elasticsearch_password  = var.elasticsearch_password
  elasticsearch_image     = var.elasticsearch_image
  elasticsearch_image_tag = var.elasticsearch_image_tag
}

# Platform Services - MySQL Database
module "mysql" {
  source = "../terraform-infrastructure/platform-components/mysql-database"

  mysql_version = var.mysql_version
}

# Platform Services - HashiCorp Vault Infrastructure
module "hashicorp_vault_infrastructure" {
  source = "../terraform-infrastructure/platform-components/hashicorp-vault/infrastructure"

  vault_version = var.vault_version
}

# Platform Services - HashiCorp Vault Config - JWT Auth Backend
module "hashicorp_vault_config_jwt_auth_backend" {
  source = "../terraform-infrastructure/platform-components/hashicorp-vault/config/jwt-auth-backend"

  vault_token        = var.vault_token
  vault_address      = var.vault_address
  oidc_discovery_url = var.oidc_discovery_url
  oidc_client_id     = module.auth0-app.client_id
  oidc_client_secret = module.auth0-app.client_secret

  depends_on = [
    module.hashicorp_vault_infrastructure,
    module.hashicorp_vault_config_acl_policies
  ]
}

# Platform Services - HashiCorp Vault Config - ACL Policies
module "hashicorp_vault_config_acl_policies" {
  source = "../terraform-infrastructure/platform-components/hashicorp-vault/config/policies"

  depends_on = [module.hashicorp_vault_infrastructure]
}

# Platform Services - HashiCorp Vault Config - KV Secrets Engine
module "hashicorp_vault_config_kv_secrets_engine" {
  source = "../terraform-infrastructure/platform-components/hashicorp-vault/config/kv-secrets-engine"

  depends_on = [module.hashicorp_vault_infrastructure]
}

# Platform Services - HashiCorp Vault Config - App Roles
module "hashicorp_vault_config_approle" {
  source = "../terraform-infrastructure/platform-components/hashicorp-vault/config/approle"

  depends_on = [module.hashicorp_vault_infrastructure]
}

# Platform Services - ESO
module "external_secrets_operator" {
  source = "../terraform-infrastructure/platform-components/external-secrets-operator"

  eso_version = var.eso_version
}

# Platform Components - NGINX Ingress Controller
module "nginx_ingress_controller" {
  source = "../terraform-infrastructure/platform-components/nginx-ingress-controller"

  nginx_version = var.nginx_ingress_controller_version

  depends_on = [module.aws_eks_cluster]

}

# Platform Components - Cert Manager
module "cert_manager" {
  source = "../terraform-infrastructure/platform-components/cert-manager"

  cert_manager_version = var.cert_manager_version

  depends_on = [module.aws_eks_cluster]
}

# Platform Components - Prometheus
module "prometheus" {
  source = "../terraform-infrastructure/platform-components/prometheus"

  prometheus_version = var.prometheus_version
}

# Platform Components - Loki
module "loki" {
  source = "../terraform-infrastructure/platform-components/loki"

  loki_version = var.loki_version
}

# Other Infrastructure - Auth0
module "auth0-app" {
  source = "../terraform-infrastructure/other-infrastructure/auth0"

  vault_address = var.vault_address
}

# AWS ARN Role
module "aws_arn_role" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-iam-role"

}

# AWS VPC
module "aws_vpc" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-vpc"

  environment = var.environment
}

# AWS ECR
module "aws_ecr" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-ecr"

  environment = var.environment
}

# AWS S3
module "aws_s3" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-s3"

  environment = var.environment
}

# AWS Cognito User Pool
module "aws_cognito_user_pool" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-cognito-user-pool"

}

# AWS Cognito User Pool Client
module "aws_cognito_user_pool_client" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-cognito-user-pool-client"

  vault_address   = var.vault_address
  grafana_address = var.k8s_grafana_ingress_url
  user_pool_id    = module.aws_cognito_user_pool.cognito_user_pool_id
}

# AWS Subnet
module "aws_subnet" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-subnet"

  eks_vpc_id  = local.eks_vpc_id
  rds_vpc_id  = local.rds_vpc_id
  environment = var.environment

  depends_on = [module.aws_vpc]
}

# AWS Internet Gateway
module "aws_internet_gateway" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-internet-gateway"

  eks_vpc_id  = local.eks_vpc_id
  environment = var.environment

  depends_on = [module.aws_vpc]
}

# AWS RDS DB
module "aws_rds_db" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-rds"

  environment           = var.environment
  db_username           = var.db_username
  db_password           = var.db_password
  rds_subnet_group_id   = module.aws_subnet.rds_subnet_group_id
  rds_security_group_id = module.aws_security_group.rds_security_group_id

  depends_on = [
    module.aws_subnet,
    module.aws_security_group
  ]
}

# AWS Route Table
module "aws_route_table" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-route-table"

  eks_vpc_id              = local.eks_vpc_id
  environment             = var.environment
  gateway_id              = module.aws_internet_gateway.internet_gateway_id
  eks_primary_subnet_id   = module.aws_subnet.eks_primary_subnet_id
  eks_secondary_subnet_id = module.aws_subnet.eks_secondary_subnet_id

  depends_on = [module.aws_subnet]
}

# AWS Security Group
module "aws_security_group" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-security-group"

  eks_vpc_id  = local.eks_vpc_id
  rds_vpc_id  = local.rds_vpc_id
  public_ips  = var.public_ips
  environment = var.environment

  depends_on = [module.aws_vpc]
}

# AWS VPC Endpoint
module "aws_vpc_endpoint" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-vpc-endpoint"

  eks_vpc_id              = local.eks_vpc_id
  environment             = var.environment
  route_table_id          = module.aws_route_table.route_table_id
  eks_primary_subnet_id   = module.aws_subnet.eks_primary_subnet_id
  eks_secondary_subnet_id = module.aws_subnet.eks_secondary_subnet_id
  eks_security_group_id   = module.aws_security_group.eks_security_group_id

  depends_on = [
    module.aws_vpc,
    module.aws_subnet,
    module.aws_security_group
  ]
}

# AWS EKS Cluster
module "aws_eks_cluster" {
  source = "../terraform-infrastructure/aws-infrastructure/aws-eks-cluster"

  environment             = var.environment
  min_node_count          = var.min_node_count
  max_node_count          = var.max_node_count
  instance_type           = var.instance_type
  eks_cluster_version     = var.eks_cluster_version
  role_arn_primary        = module.aws_arn_role.iam_role_arn_primary
  role_arn_secondary      = module.aws_arn_role.iam_role_arn_secondary
  eks_subnet_id_primary   = module.aws_subnet.eks_primary_subnet_id
  eks_subnet_id_secondary = module.aws_subnet.eks_secondary_subnet_id

  depends_on = [
    module.aws_vpc,
    module.aws_arn_role
  ]

}