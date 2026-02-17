resource "aws_iam_role" "eks_ci_deploy" {
  name = "${var.name_prefix}-eks-ci-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = var.ci_principal_arn
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "eks_ci_policy" {
  name = "${var.name_prefix}-eks-ci-policy"
  role = aws_iam_role.eks_ci_deploy.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer"
        ]
        Resource = "*"
      }
    ]
  })
}
