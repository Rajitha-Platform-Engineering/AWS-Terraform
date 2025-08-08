variable "environment" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "node_type" {
  type    = string
  default = "dc2.large"
}

variable "number_of_nodes" {
  type    = number
  default = 2
}
