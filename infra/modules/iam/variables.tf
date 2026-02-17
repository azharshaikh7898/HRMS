variable "name_prefix" { type = string }
variable "ci_principal_arn" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
