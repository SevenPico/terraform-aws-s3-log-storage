## ----------------------------------------------------------------------------
##  Copyright 2023 SevenPico, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
## ----------------------------------------------------------------------------

## ----------------------------------------------------------------------------
##  ./examples/complete/_variables.tf
##  This file contains code written by SevenPico, Inc.
## ----------------------------------------------------------------------------

variable "s3_lifecycle_configuration_rules" {
  default = [
    {
      enabled                                = true # bool
      id                                     = "standard"
      abort_incomplete_multipart_upload_days = 1 # number
      filter_and                             = null
      expiration = {
        days = 120 # integer > 0
      }
      noncurrent_version_expiration = {
        newer_noncurrent_versions = 3  # integer > 0
        noncurrent_days           = 60 # integer >= 0
      }
      transition = [
        {
          days          = 30 # integer >= 0
          storage_class = "STANDARD_IA"
          # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
        },
        {
          days          = 60 # integer >= 0
          storage_class = "ONEZONE_IA"
          # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
        }
      ]
      noncurrent_version_transition = [
        {
          newer_noncurrent_versions = 3  # integer >= 0
          noncurrent_days           = 30 # integer >= 0
          storage_class             = "ONEZONE_IA"
          # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
        }
      ]
    }
  ]

}
