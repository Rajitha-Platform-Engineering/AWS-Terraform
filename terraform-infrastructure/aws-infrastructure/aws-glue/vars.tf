variable "environment" {
  type = string
}

variable "glue_iam_role_arn" {
  type = string
}

variable "data_lake_bucket" {
  type = string
}

variable "data_lake_prefix" {
  type    = string
  default = "raw/"
}

variable "scripts_bucket" {
  type = string
}

variable "etl_script_key" {
  type = string
}

variable "crawler_schedule" {
  type    = string
  default = "cron(0 12 * * ? *)"
}

variable "number_of_workers" {
  type    = number
  default = 5
}

variable "worker_type" {
  type    = string
  default = "G.1X"
}
