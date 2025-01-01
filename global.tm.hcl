# Import all mixins from the mixins directory
import {
    source = "/mixins/*.tm.hcl"
}

# Configure default Terraform version in all stacks
globals "terraform" {
  version = "1.9.5"
}

# Configure default backend in all stacks (can be overridden)
globals "terraform" "backend" {
  bucket = "terramate-workshop-state-bucket-${global.aws.account_id}"
  region = "eu-north-1"
}

# Will be added to all stacks unless overridden
globals "terraform" "providers" "aws" {
  source  = "hashicorp/aws"
  version = "5.82.2"
  enabled = true
  # Set the default region for the AWS provider
  config = {
    region = "eu-north-1"
  }
}