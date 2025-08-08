output "eks_vpc_id" {
  value = aws_vpc.primary.id
}

output "rds_vpc_id" {
  value = aws_vpc.secondary.id
}