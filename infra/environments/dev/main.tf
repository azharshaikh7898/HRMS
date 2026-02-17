locals {
  name_prefix = "hrms-dev"
  tags = {
    Environment = "dev"
    Project     = "hrms"
    Owner       = "platform"
  }
}

module "network" {
  source           = "../../modules/network"
  name_prefix      = local.name_prefix
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets
  tags             = local.tags
}

module "eks" {
  source                  = "../../modules/eks"
  name_prefix             = local.name_prefix
  cluster_version         = var.cluster_version
  vpc_id                  = module.network.vpc_id
  private_subnet_ids      = module.network.private_subnet_ids
  critical_instance_types = var.critical_instance_types
  critical_min_size       = var.critical_min_size
  critical_max_size       = var.critical_max_size
  critical_desired_size   = var.critical_desired_size
  general_instance_types  = var.general_instance_types
  general_capacity_type   = var.general_capacity_type
  general_min_size        = var.general_min_size
  general_max_size        = var.general_max_size
  general_desired_size    = var.general_desired_size
  tags                    = local.tags
}

resource "aws_kms_key" "data" {
  description             = "KMS key for HRMS dev data encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags                    = local.tags
}

module "s3" {
  source      = "../../modules/s3"
  name_prefix = local.name_prefix
  kms_key_arn = aws_kms_key.data.arn
  tags        = local.tags
}

module "rds" {
  source                 = "../../modules/rds"
  name_prefix            = local.name_prefix
  vpc_id                 = module.network.vpc_id
  database_subnet_ids    = module.network.database_subnet_ids
  app_security_group_id  = module.eks.cluster_primary_security_group_id
  kms_key_arn            = aws_kms_key.data.arn
  db_name                = var.db_name
  db_username            = var.db_username
  db_port                = var.db_port
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  max_allocated_storage  = var.db_max_allocated_storage
  backup_retention_days  = var.db_backup_retention_days
  create_read_replica    = var.create_read_replica
  replica_instance_class = var.replica_instance_class
  tags                   = local.tags
}
