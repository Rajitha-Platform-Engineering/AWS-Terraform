variable "environment" {
  type = string
}

variable "nginx_ingress_controller_version" {
  type = string
}

variable "cert_manager_version" {
  type = string
}

variable "min_node_count" {
  type = string
}

variable "max_node_count" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "elasticsearch_version" {
  type = string
}

variable "prometheus_version" {
  type = string
}

variable "loki_version" {
  type = string
}

variable "eso_version" {
  type = string
}

variable "mysql_version" {
  type = string
}

variable "public_ips" {
  type = list(string)
}

variable "k8s_prometheus_ingress_url" {
  type = string
}

variable "k8s_grafana_ingress_url" {
  type = string
}

variable "k8s_alertmanager_ingress_url" {
  type = string
}

variable "elasticsearch_password" {
  type = string
}

variable "elasticsearch_image" {
  type = string
}

variable "elasticsearch_image_tag" {
  type = string
}

variable "vault_version" {
  type = string
}

variable "k8s_vault_ingress_url" {
  type = string
}

variable "vault_token" {
  type = string
}

variable "vault_address" {
  type = string
}

variable "grafana_oauth_client_id" {
  type = string
}

variable "oidc_discovery_url" {
  type = string
}