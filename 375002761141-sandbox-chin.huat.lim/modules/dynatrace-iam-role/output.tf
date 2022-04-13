output "arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.dynatrace.arn
}

output "name" {
  description = "Name (Id) of the IAM role"
  value       = aws_iam_role.dynatrace.id
}