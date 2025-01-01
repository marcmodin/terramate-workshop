# Generate a dynamic backend configuration
generate_hcl "_backend.tf" {
  condition = !tm_contains(terramate.stack.tags, "no-backend")

  content {
    terraform {
      backend "s3" {
        region  = global.terraform.backend.region
        bucket  = global.terraform.backend.bucket
        #  use the stack id to create a unique key for each stack (bye bye, path collisions)
        key     = tm_try(global.terraform.backend.key, "stacks/by-id/${terramate.stack.id}/terraform.tfstate")
        encrypt = true
      }
    }
  }
}