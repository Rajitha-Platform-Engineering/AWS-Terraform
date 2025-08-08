resource "aws_kinesis_stream" "main" {
  name             = "${var.environment}-kinesis-stream"
  shard_count      = var.shard_count
  retention_period = var.retention_period

  stream_mode_details {
    stream_mode = var.stream_mode
  }

  encryption_type = "KMS"
  kms_key_id      = "alias/aws/kinesis"

  tags = {
    Name = "${var.environment}-kinesis-stream"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "main" {
  name        = "${var.environment}-kinesis-firehose"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn           = var.firehose_iam_role_arn
    bucket_arn         = var.s3_bucket_arn
    buffering_size     = 128
    buffering_interval = 300
    compression_format = "GZIP"

    prefix              = "data/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/"
    error_output_prefix = "errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/!{firehose:error-output-type}/"
  }

  tags = {
    Name = "${var.environment}-kinesis-firehose"
  }
}
