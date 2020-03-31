output "arn" {
  description = "Full ARN of the repository."
  value       = aws_ecr_repository.main.arn
}

output "name" {
  description = "The name of the repository."
  value       = aws_ecr_repository.main.name
}
