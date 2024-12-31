# Generate terraform version constraints
generate_hcl "_versions.tf" {

  lets {
    required_providers = { for k, v in tm_try(global.terraform.providers, {}) :
      k => {
        source  = v.source
        version = v.version
        } if tm_alltrue([
          tm_try(v.enabled, true),
          tm_length(tm_split(".", k)) == 1,
      ])
    }
  }

  content {
    terraform {
      required_version = tm_try(global.terraform.version, "~> 1.9")
      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }
    }
  }
}