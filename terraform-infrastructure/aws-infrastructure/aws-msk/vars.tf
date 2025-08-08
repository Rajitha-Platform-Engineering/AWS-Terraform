variable "environment" {
  type = string
}

variable "kafka_version" {
  type    = string
  default = "3.5.1"
}

variable "number_of_broker_nodes" {
  type    = number
  default = 3
}

variable "broker_instance_type" {
  type    = string
  default = "kafka.m5.large"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "broker_volume_size" {
  type    = number
  default = 100
}
