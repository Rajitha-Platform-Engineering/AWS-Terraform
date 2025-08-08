variable "environment" {
  type = string
}

variable "shard_count" {
  type    = number
  default = 2
}

variable "retention_period" {
  type    = number
  default = 24
}

variable "stream_mode" {
  type    = string
  default = "PROVISIONED"
}

variable "firehose_iam_role_arn" {
  type = string
}

variable "s3_bucket_arn" {
  type = string
}
