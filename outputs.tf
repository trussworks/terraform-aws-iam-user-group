output "group_name" {
  description = "The name of the created group."
  value       = aws_iam_group.user_group.name
}
