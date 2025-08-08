output "redshift_cluster_id" {
  value = aws_redshift_cluster.main.id
}

output "redshift_endpoint" {
  value = aws_redshift_cluster.main.endpoint
}
