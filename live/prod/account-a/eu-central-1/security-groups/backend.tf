terraform {
  backend "s3" {
    region         = "eu-north-1"
    bucket         = "terramate-workshop-state-bucket-012345678901"
    key            = "prod/eu-central-1/security-groups/terraform.tfstate"
    encrypt        = true
  }
}