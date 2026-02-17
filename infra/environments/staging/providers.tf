provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "staging"
      Project     = "hrms"
      ManagedBy   = "terraform"
    }
  }
}
