resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.database_subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "rds" {
  name        = "${var.name_prefix}-rds-sg"
  description = "RDS access from EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_instance" "primary" {
  identifier                          = "${var.name_prefix}-postgres"
  engine                              = "postgres"
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  db_name                             = var.db_name
  username                            = var.db_username
  manage_master_user_password         = true
  db_subnet_group_name                = aws_db_subnet_group.this.name
  vpc_security_group_ids              = [aws_security_group.rds.id]
  storage_encrypted                   = true
  kms_key_id                          = var.kms_key_arn
  backup_retention_period             = var.backup_retention_days
  backup_window                       = "03:00-04:00"
  maintenance_window                  = "sun:04:00-sun:05:00"
  multi_az                            = true
  skip_final_snapshot                 = false
  deletion_protection                 = true
  apply_immediately                   = false
  auto_minor_version_upgrade          = true
  performance_insights_enabled        = true
  performance_insights_kms_key_id     = var.kms_key_arn
  enabled_cloudwatch_logs_exports     = ["postgresql", "upgrade"]
  copy_tags_to_snapshot               = true
  publicly_accessible                 = false
  iam_database_authentication_enabled = true
  tags                                = var.tags
}

resource "aws_db_instance" "replica" {
  count                               = var.create_read_replica ? 1 : 0
  identifier                          = "${var.name_prefix}-postgres-replica"
  replicate_source_db                 = aws_db_instance.primary.identifier
  instance_class                      = var.replica_instance_class
  publicly_accessible                 = false
  auto_minor_version_upgrade          = true
  performance_insights_enabled        = true
  performance_insights_kms_key_id     = var.kms_key_arn
  copy_tags_to_snapshot               = true
  deletion_protection                 = true
  apply_immediately                   = false
  tags                                = var.tags
}
