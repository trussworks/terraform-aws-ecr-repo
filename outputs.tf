output "arn" {
  description = "Full ARN of the repository."
  value       = aws_ecr_repository.main.arn
}

output "repo_url" {
  description = "The URL for the repository created."
  value       = aws_ecr_repository.main.repository_url
}
