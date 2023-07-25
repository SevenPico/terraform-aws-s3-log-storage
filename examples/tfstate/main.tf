
module "tfstate" {
  source  = "../../modules/lb-access"
  context = module.context.self

  access_log_bucket_name            = ""
  access_log_bucket_prefix_override = ""
  create_kms_key                    = true
  enable_mfa_delete                 = false
  enable_versioning                 = true
  force_destroy                     = true
  kms_key_deletion_window_in_days   = 30
  kms_key_enable_key_rotation       = true
  lifecycle_configuration_rules     = []
  s3_object_ownership               = "BucketOwnerPreferred"
  s3_replication_enabled            = false
  s3_replication_rules              = var.s3_lifecycle_configuration_rules
  s3_replication_source_roles       = []
  s3_source_policy_documents        = []
}
