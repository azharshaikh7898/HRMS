variable "name_prefix" { type = string }
variable "kms_key_arn" { type = string }

variable "transition_to_ia_days" {
  type    = number
  default = 30
}

variable "transition_to_glacier_ir_days" {
  type    = number
  default = 90
}

variable "noncurrent_transition_days" {
  type    = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}
