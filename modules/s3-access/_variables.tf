variable "lifecycle_configuration_rules" {
  type    = any
  default = []
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "s3_bucket_policy_source_json" {
  type    = string
  default = ""
}

variable "access_log_to_self" {
  type        = bool
  default     = true
  description = "If true, the bucket will record its access logs to itself."
}

variable "access_log_bucket_name" {
  type        = string
  default     = null
  description = "Name of the S3 bucket where S3 access logs will be sent to."
}

variable "access_log_bucket_prefix_override" {
  type        = string
  default     = null
  description = "Prefix to prepend to the current S3 bucket name, where S3 access logs will be sent to"
}
