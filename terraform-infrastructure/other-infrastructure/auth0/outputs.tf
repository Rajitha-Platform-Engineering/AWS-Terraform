output "client_id" {
  value = auth0_client.vault.client_id
}

output "client_secret" {
  value = auth0_client_credentials.vault_client_creds.client_secret
}