output "iam_role_arn_primary" {
  value = aws_iam_role.primary.arn
}

output "iam_role_arn_secondary" {
  value = aws_iam_role.secondary.arn
}