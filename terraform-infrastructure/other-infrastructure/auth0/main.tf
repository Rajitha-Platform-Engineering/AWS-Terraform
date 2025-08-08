resource "auth0_client" "vault" {
  name        = "Vault-New"
  description = "OIDC App for test Vault"
  app_type    = "regular_web"
  callbacks   = ["${var.vault_address}/ui/vault/auth/oidc/oidc/callback"]

  oidc_conformant = true

  jwt_configuration {
    alg                 = "RS256"
    lifetime_in_seconds = 3600
    secret_encoded      = false
  }

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit",
    "client_credentials",
  ]

}

resource "auth0_client_credentials" "vault_client_creds" {
  client_id             = auth0_client.vault.id
  authentication_method = "client_secret_post"
}
