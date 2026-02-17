output "vpc_id" {
  value = module.network.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "document_buckets" {
  value = module.s3.bucket_names
}
