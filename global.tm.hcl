# Configure default Terraform version in all stacks
globals "terraform" {
  version = "1.9.5"
}

# Will be added to all stacks
globals "terraform" "providers" "aws" {
  source  = "hashicorp/aws"
  version = "5.82.2"
  enabled = true
}