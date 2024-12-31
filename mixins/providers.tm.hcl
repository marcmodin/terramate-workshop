# Generates the terraform provider configurations
generate_hcl "_providers.tf" {

  lets {
    providers = { for k, v in tm_try(global.terraform.providers, {}) :
      k => v.config if tm_alltrue([
        tm_length(tm_split(".", k)) == 1,
        tm_try(v.enabled, true),
        tm_can(v.config)
      ])
    }
  }

  content {
    # Provider configs
    tm_dynamic "provider" {
      for_each   = let.providers
      labels     = [provider.key]
      attributes = provider.value
      content {
        allowed_account_ids = [global.aws.account_id]
      }
    }
  }
}