data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.name_prefix}-vpc"
  cidr = var.vpc_cidr

  azs              = local.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  single_nat_gateway     = false
  enable_dns_hostnames   = true
  enable_dns_support     = true

  create_database_subnet_group = true

  tags = var.tags
}
