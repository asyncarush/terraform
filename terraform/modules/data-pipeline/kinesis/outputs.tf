output "stream_name" {
  description = "Name of the Kinesis stream"
  value       = aws_kinesis_stream.data_stream.name
}

output "stream_arn" {
  description = "ARN of the Kinesis stream"
  value       = aws_kinesis_stream.data_stream.arn
}

output "firehose_name" {
  description = "Name of the Kinesis Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.firehose_stream.name
}

output "firehose_arn" {
  description = "ARN of the Kinesis Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.firehose_stream.arn
}
