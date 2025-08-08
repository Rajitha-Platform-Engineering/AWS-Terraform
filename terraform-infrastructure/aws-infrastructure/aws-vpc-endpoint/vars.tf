variable "environment" {
  type = string
}

variable "eks_vpc_id" {
  type = string
}

variable "route_table_id" {
  type = string
}

variable "eks_primary_subnet_id" {
  type = string
}

variable "eks_secondary_subnet_id" {
  type = string
}

variable "eks_security_group_id" {
  type = string
}