// Configure environment variables
globals "aws" {
  name       = "account-a"
  account_id = "012345678901"
}

globals "terraform" "backend" {
  bucket = "terramate-workshop-state-bucket-${global.aws.account_id}"
  key    = "${global.environment}/${global.terraform.providers.aws.config.region}/${terramate.stack.name}/terraform.tfstate"
  region = "eu-north-1"
}
