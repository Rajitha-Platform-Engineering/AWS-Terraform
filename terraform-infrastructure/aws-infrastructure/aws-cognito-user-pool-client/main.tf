resource "aws_cognito_user_pool_client" "vault" {
  name            = "Vault"
  user_pool_id    = var.user_pool_id
  generate_secret = true

  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  allowed_oauth_flows                  = ["code"]

  callback_urls = ["${var.vault_address}/ui/vault/auth/oidc/oidc/callback"]
  logout_urls   = []

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

resource "aws_cognito_user_pool_client" "grafana" {
  name            = "Grafana"
  user_pool_id    = var.user_pool_id
  generate_secret = true

  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  allowed_oauth_flows                  = ["code"]

  callback_urls = ["https://${var.grafana_address}/login/generic_oauth"]
  logout_urls   = ["https://grafana.test.io/login"]

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}

# Managed Login Page - UI
resource "aws_cognito_user_pool_domain" "vault_domain" {
  domain       = "test"
  user_pool_id = var.user_pool_id
}