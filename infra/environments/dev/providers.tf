provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "hrms"
      ManagedBy   = "terraform"
    }
  }
}
