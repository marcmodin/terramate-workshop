globals "modules" "remote_state" {
  name = "terramate-workshop-state-bucket-${global.aws.account_id}"
  source = "github.com/marcmodin/random-terraform-aws-remote-state-module.git?ref=main"
  create_iam_policy = false
}