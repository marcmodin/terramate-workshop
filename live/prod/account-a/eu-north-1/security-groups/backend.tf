terraform {
  backend "s3" {
    region         = "eu-north-1"
    bucket         = "terramate-workshop-state-bucket"
    key            = "prod/eu-north-1/security-groups/terraform.tfstate"
    encrypt        = true
  }
}