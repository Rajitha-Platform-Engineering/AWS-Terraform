terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "1.24.1"
    }
  }
  backend "s3" {
    bucket = "terraform-state-test-io"
    key    = "environments/staging/terraformstate.tfstate"
    region = "eu-central-1"
  }

}

provider "aws" {
  region = "eu-central-1"
}

provider "vault" {
  address = "https://vault-dev.test.io"
  token   = local.vault_token
}

provider "auth0" {
  domain        = local.auth0_domain
  client_id     = local.auth0_client_id
  client_secret = local.auth0_client_secret
}
