output "kinesis_stream_arn" {
  value = aws_kinesis_stream.main.arn
}

output "kinesis_stream_name" {
  value = aws_kinesis_stream.main.name
}

output "firehose_delivery_stream_arn" {
  value = aws_kinesis_firehose_delivery_stream.main.arn
}
