# Read-only access across all secrets, auth methods, etc.
path "*" {
  capabilities = ["read", "list"]
}