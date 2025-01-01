// Configure environment variables
globals "aws" {
  name       = "account-a"
  account_id = "971422678851"
}

globals "terraform" "backend" {
  bucket = "terramate-workshop-state-bucket-${global.aws.account_id}"
  region = "eu-north-1"
}
