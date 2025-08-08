variable "environment" {
  type = string
}

variable "eks_subnet_id_primary" {
  type = string
}

variable "eks_subnet_id_secondary" {
  type = string
}

variable "role_arn_primary" {
  type = string
}

variable "role_arn_secondary" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "min_node_count" {
  type = string
}

variable "max_node_count" {
  type = string
}

variable "instance_type" {
  type = string
}