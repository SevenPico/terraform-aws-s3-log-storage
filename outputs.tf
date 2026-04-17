output "bucket_domain_name" {
  value       = module.aws_s3_bucket.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_regional_domain_name" {
  value       = module.aws_s3_bucket.bucket_regional_domain_name
  description = "Regional FQDN of bucket."
}

output "bucket_id" {
  value       = try(module.aws_s3_bucket.bucket_id, null)
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = module.aws_s3_bucket.bucket_arn
  description = "Bucket ARN"
}

output "bucket_notifications_sqs_queue_arn" {
  value       = join("", aws_sqs_queue.notifications.*.arn)
  description = "Notifications SQS queue ARN"
}

output "enabled" {
  value       = module.context.enabled
  description = "Is module enabled"
}
