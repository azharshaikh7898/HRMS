output "eks_ci_role_arn" {
  value = aws_iam_role.eks_ci_deploy.arn
}
