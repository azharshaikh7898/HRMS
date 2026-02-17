module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.name_prefix}-eks"
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    critical = {
      instance_types = var.critical_instance_types
      min_size       = var.critical_min_size
      max_size       = var.critical_max_size
      desired_size   = var.critical_desired_size
      capacity_type  = "ON_DEMAND"
      labels = {
        workload = "critical"
      }
    }
    general = {
      instance_types = var.general_instance_types
      min_size       = var.general_min_size
      max_size       = var.general_max_size
      desired_size   = var.general_desired_size
      capacity_type  = var.general_capacity_type
      labels = {
        workload = "general"
      }
    }
  }

  tags = var.tags
}
