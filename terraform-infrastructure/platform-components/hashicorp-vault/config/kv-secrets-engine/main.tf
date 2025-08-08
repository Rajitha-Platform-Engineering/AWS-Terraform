resource "vault_mount" "kv" {
  path = "secret"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "KV Version 2 secret engine mount"
}