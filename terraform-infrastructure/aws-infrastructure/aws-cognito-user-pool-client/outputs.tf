output "client_id" {
  value = aws_cognito_user_pool_client.vault.id
}

output "vault_client_secret" {
  value = aws_cognito_user_pool_client.vault.client_secret
}

output "grafana_client_secret" {
  value = aws_cognito_user_pool_client.grafana.client_secret
}