variable "create_kms_key" {
  type = bool
  default = false
}

variable "lifecycle_configuration_rules" {
  type    = any
  default = []
}

variable "force_destroy" {
  type    = bool
  default = false
}

#variable "kms_key_policy_source_json" {
#  type    = string
#  default = ""
#}

variable "access_log_bucket_name" {
  type        = string
  default     = null
  description = "Name of the S3 bucket where S3 access logs will be sent to"
}

variable "access_log_bucket_prefix_override" {
  type        = string
  default     = null
  description = "Prefix to prepend to the current S3 bucket name, where S3 access logs will be sent to"
}

variable "kms_key_deletion_window_in_days" {
  type    = number
  default = 30
}

variable "kms_key_enable_key_rotation" {
  type    = bool
  default = true
}

variable "s3_source_policy_documents" {
  type        = list(string)
  default     = []
  description = <<-EOT
    List of IAM policy documents that are merged together into the exported document.
    Statements defined in source_policy_documents must have unique SIDs.
    Statement having SIDs that match policy SIDs generated by this module will override them.
    EOT
}

variable "source_accounts" {
  type = list(string)
  default = []
  description = "List of Account IDs allowed to write to this log bucket."
}

variable "s3_replication_enabled" {
  type        = bool
  default     = false
  description = "Set this to true and specify `s3_replication_rules` to enable replication. `versioning_enabled` must also be `true`."
}

variable "s3_replication_rules" {
  type        = list(any)
  default     = null
  description = "Specifies the replication rules for S3 bucket replication if enabled. You must also set s3_replication_enabled to true."
}

variable "s3_replication_source_roles" {
  type        = list(string)
  default     = []
  description = "Cross-account IAM Role ARNs that will be allowed to perform S3 replication to this bucket (for replication within the same AWS account, it's not necessary to adjust the bucket policy)."
}

variable "s3_object_ownership" {
  type        = string
  default     = "BucketOwnerEnforced"
  description = "Specifies the S3 object ownership control. Valid values are `ObjectWriter`, `BucketOwnerPreferred`, and 'BucketOwnerEnforced'."
}

variable "enable_mfa_delete" {
  type = bool
  default = false
  description = "Note that it only applies when Versioning is enabled"
}
