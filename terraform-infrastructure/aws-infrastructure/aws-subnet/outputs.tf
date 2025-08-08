output "eks_primary_subnet_id" {
  value = aws_subnet.eks_primary.id
}

output "eks_secondary_subnet_id" {
  value = aws_subnet.eks_secondary.id
}

output "rds_subnet_group_id" {
  value = aws_db_subnet_group.main.id
}