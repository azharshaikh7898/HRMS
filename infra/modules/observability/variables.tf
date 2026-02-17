variable "name_prefix" { type = string }
variable "environment" { type = string }
variable "eks_cluster_name" { type = string }
variable "kms_key_arn" { type = string }
variable "log_retention_days" { type = number }
variable "alarm_actions" { type = list(string) }
variable "tags" {
  type    = map(string)
  default = {}
}
