locals {
  approle_files = fileset("${path.module}/app-roles", "*.json")

  approle_data = {
    for file in local.approle_files :
    file => jsondecode(file("${path.module}/app-roles/${file}"))
  }
}

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "approle" {
  for_each = local.approle_data

  backend   = vault_auth_backend.approle.path
  role_name = each.value.name

  token_policies = ["default", "dev", "prod"]
}
