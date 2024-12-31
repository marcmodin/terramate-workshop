terraform {
  backend "s3" {
    region         = "eu-north-1"
    bucket         = "terramate-workshop-state-bucket-02340283049820"
    key            = "prod/eu-central-1/vpc/terraform.tfstate"
    encrypt        = true
  }
}