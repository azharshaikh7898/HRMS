provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "prod"
      Project     = "hrms"
      ManagedBy   = "terraform"
    }
  }
}
