locals {
  vault_token = var.vault_token

  auth0_client_id     = "AUTH0_CLIENT_ID_PLACEHOLDER"
  auth0_client_secret = "AUTH0_SECRET_ID_PLACEHOLDER"
  auth0_domain        = "auth0-domain"
}

module "test-io" {
  source = "../../modules/"

  # EKS Cluster Node Count
  min_node_count = "4"
  max_node_count = "5"

  # Platform Version
  eks_cluster_version = "1.32"

  # Platform Components Version
  elasticsearch_version            = "8.5.1"
  mysql_version                    = "9.8.2"
  cert_manager_version             = "1.17.2"
  nginx_ingress_controller_version = "4.12.0"
  prometheus_version               = "56.6.2"
  loki_version                     = "2.10.2"
  vault_version                    = "0.30.0"
  eso_version                      = "0.18.1"

  # Ingress URLs
  k8s_vault_ingress_url        = "YOUR_VAULT_URL"
  k8s_grafana_ingress_url      = "YOUR_GRAFANA_URL"
  k8s_prometheus_ingress_url   = "YOUR_PROMETHEUS_URL"
  k8s_alertmanager_ingress_url = "YOUR_ALERTMANAGER_URL"

  # Hashicorp Vault
  vault_token        = local.vault_token
  oidc_discovery_url = local.auth0_domain
  vault_address      = "YOUR_VAULT_URL"

  # Grafana Auth
  grafana_oauth_client_id = "CLIENT_ID_OF_YOUR_AWS_COGNITO_APP"

  # Other Vars
  environment             = "staging"
  db_username             = "DB_USERNAME"
  instance_type           = "t2.medium"
  elasticsearch_image_tag = "elasticsearch-v2"
  db_password             = "MYSQL_DB_PASSWORD_PLACEHOLDER"
  elasticsearch_password  = "ELASTICSEARCH_PASSWORD_PLACEHOLDER"
  elasticsearch_image     = "YOUR_AWS_ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com/staging-ecr"

  # Allowed Public IPs for the DB
  public_ips = [
    "x.x.x.x/32", # Developer 1's Public IP Address
    "x.x.x.x/32"  # Developer 2's Public IP Address
  ]
}
