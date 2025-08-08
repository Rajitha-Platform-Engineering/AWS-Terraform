locals {
  policy_files = fileset("${path.module}/acl-policies", "*.hcl")
  policies = { for file in local.policy_files :
    trimsuffix(file, ".hcl") => file("${path.module}/acl-policies/${file}")
  }
}

# ACL Policy
resource "vault_policy" "main" {
  for_each = local.policies

  name   = each.key
  policy = each.value
}