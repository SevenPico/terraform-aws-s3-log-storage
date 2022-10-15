# ------------------------------------------------------------------------------
# S3 Log Storage Context
# ------------------------------------------------------------------------------
module "s3_log_storage_context" {
  source     = "app.terraform.io/SevenPico/context/null"
  version    = "1.0.2"
  context    = module.context.self
  attributes = ["s3-access-logs"]
}


# ------------------------------------------------------------------------------
# S3 Log Storage
# ------------------------------------------------------------------------------
module "s3_log_storage" {
  source  = "../../"
  context = module.s3_log_storage_context.self

  access_log_bucket_name            = var.access_log_to_self ? null : var.access_log_bucket_name
  access_log_bucket_prefix_override = var.access_log_bucket_prefix_override
  acl                               = "log-delivery-write"
  allow_encrypted_uploads_only      = false
  allow_ssl_requests_only           = true
  block_public_acls                 = true
  block_public_policy               = true
  bucket_key_enabled                = false
  bucket_name                       = null
  bucket_notifications_enabled      = false
  bucket_notifications_prefix       = ""
  bucket_notifications_type         = "SQS"
  enable_mfa_delete                 = var.enable_mfa_delete
  force_destroy                     = var.force_destroy
  ignore_public_acls                = true
  kms_master_key_arn                = ""
  lifecycle_configuration_rules     = var.lifecycle_configuration_rules
  restrict_public_buckets           = true
  s3_object_ownership               = var.s3_object_ownership
  source_policy_documents           = var.s3_source_policy_documents
  sse_algorithm                     = "AES256"
  enable_versioning                 = true

  s3_replication_enabled      = var.s3_replication_enabled
  s3_replication_rules        = var.s3_replication_rules
  s3_replication_source_roles = var.s3_replication_source_roles
}

resource "aws_s3_bucket_logging" "self" {
  count      = module.s3_log_storage_context.enabled && var.access_log_to_self ? 1 : 0
  depends_on = [module.s3_log_storage]

  bucket        = module.s3_log_storage.bucket_id
  target_bucket = module.s3_log_storage.bucket_id
  target_prefix = var.access_log_bucket_prefix_override == null ? "${data.aws_caller_identity.current.account_id}/${module.s3_log_storage_context.id}/" : (var.access_log_bucket_prefix_override != "" ? "${var.access_log_bucket_prefix_override}/" : "")
}
