# ------------------------------------------------------------------------------
# KMS Key Policy Context
# ------------------------------------------------------------------------------
module "kms_key_context" {
  source  = "SevenPico/context/null"
  version = "2.0.0"
  context = module.s3_log_storage_context.self
  enabled = var.create_kms_key && module.context.enabled
}


# ------------------------------------------------------------------------------
# KMS Key Policy
# ------------------------------------------------------------------------------
data "aws_iam_policy_document" "kms_key" {
  count = module.kms_key_context.enabled ? 1 : 0

  statement {
    sid    = "AwsRootAccess"
    effect = "Allow"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:Tag*",
      "kms:Untag*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    #bridgecrew:skip=CKV_AWS_109:This policy applies only to the key it is attached to
    #bridgecrew:skip=CKV_AWS_111:This policy applies only to the key it is attached to
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = ["${local.arn_prefix}:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid    = "Allow Cloudtrail and Config to use the key"
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }
  }
}


# ------------------------------------------------------------------------------
# KMS Key Policy
# ------------------------------------------------------------------------------
module "kms_key" {
  source  = "SevenPicoForks/kms-key/aws"
  version = "2.0.0"
  context = module.kms_key_context.self

  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = var.kms_key_deletion_window_in_days
  description              = "KMS key for S3"
  enable_key_rotation      = var.kms_key_enable_key_rotation
  key_usage                = "ENCRYPT_DECRYPT"
  multi_region             = false
  policy                   = join("", data.aws_iam_policy_document.kms_key.*.json)
}
