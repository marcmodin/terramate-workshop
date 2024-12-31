# Generate a dynamic backend configuration
generate_hcl "_backend.tf" {
  condition = !tm_contains(terramate.stack.tags, "no-backend")

  content {
    terraform {
      backend "s3" {
        region  = global.terraform.backend.region
        bucket  = global.terraform.backend.bucket
        key     = global.terraform.backend.key
        encrypt = true
      }
    }
  }
}