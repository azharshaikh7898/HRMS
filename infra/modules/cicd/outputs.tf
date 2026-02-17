output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "codebuild_project_name" {
  value = aws_codebuild_project.build.name
}
