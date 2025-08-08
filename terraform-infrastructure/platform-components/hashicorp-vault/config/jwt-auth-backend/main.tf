# Enable OIDC Auth Method
# Configure OIDC with Cognito
resource "vault_jwt_auth_backend" "oidc_config" {
  type               = "oidc"
  path               = "oidc"
  oidc_discovery_url = "https://${var.oidc_discovery_url}/"
  bound_issuer       = "https://${var.oidc_discovery_url}/"
  oidc_client_id     = var.oidc_client_id
  oidc_client_secret = var.oidc_client_secret
  default_role       = "default"
}

# Role for Cognito Users
resource "vault_jwt_auth_backend_role" "cognito_users" {
  backend               = "oidc"
  role_name             = "default"
  user_claim            = "sub"
  allowed_redirect_uris = ["${var.vault_address}/ui/vault/auth/oidc/oidc/callback"]
  token_policies        = ["developers-acl"]
  role_type             = "oidc"
  bound_audiences       = [var.oidc_client_id]

  depends_on = [
    vault_jwt_auth_backend.oidc_config
  ]
}