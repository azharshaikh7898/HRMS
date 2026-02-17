output "db_instance_id" {
  value = aws_db_instance.primary.id
}

output "db_endpoint" {
  value = aws_db_instance.primary.endpoint
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}
