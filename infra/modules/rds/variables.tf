variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "database_subnet_ids" { type = list(string) }
variable "app_security_group_id" { type = string }
variable "kms_key_arn" { type = string }

variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_port" { type = number }
variable "engine_version" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "max_allocated_storage" { type = number }
variable "backup_retention_days" { type = number }

variable "create_read_replica" { type = bool }
variable "replica_instance_class" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}
