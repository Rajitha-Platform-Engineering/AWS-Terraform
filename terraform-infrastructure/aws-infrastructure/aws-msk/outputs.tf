output "msk_cluster_arn" {
  value = aws_msk_cluster.main.arn
}

output "msk_bootstrap_brokers_tls" {
  value = aws_msk_cluster.main.bootstrap_brokers_tls
}

output "msk_zookeeper_connect_string" {
  value = aws_msk_cluster.main.zookeeper_connect_string
}
