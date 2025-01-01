# Part 3: Orchestrate a Multi-Account Monorepo with Code Generation and Reusable Modules

In this part, you will set up a larger-scale Terraform monorepo that builds on part-2, leveraging Terramate's powerful orchestration capabilities, create reusable modules with code generation and see how its like to work with terraform.

## Instructions

> From now on we will not disable safeguards which means you will need to add and commit your changes

If you plan to run terraform commands while following along, you will need to change the account_id to an account that you have access to at `live/prod/account-a/account.tm.hcl`, as well as setting your AWS credentials with permissions in that account.

```bash

globals "aws" {
  name       = "account-a"
  account_id = "?"
}
```

#### Boostrap Remote State

You will need to have remote-state s3 backend to be able to run terraform commands. The stack located in `live/prod/account-a/boostrap` generates the module code that you can deploy (remember to change the account_id)

Here we use an experimental feature called `tmgen` (well, not so experimental anymore!). The experimental feature have already been added to `terramate.tm.hcl`. <https://terramate.io/docs/cli/code-generation/tmgen#example>

Run Generate

```bash
terramate generate
```

Deploy the remote state bucket specifically using orchestration. Specifically `workflows` <https://terramate.io/docs/cli/orchestration/scripts>

We can deploy the remote-state either using scripts or directly using the following command

```bash
terramate --chdir live/prod/account-a/bootstrap/remote-state run -- sh -c '
  terraform init &&
  terraform apply -input=false -auto-approve
  '
```

```bash
terramate --chdir path/to/tree run -- 
```

### Orchestration

<https://terramate.io/docs/cli/orchestration/>

Controlling the order of execution. Add the following to the `security-group` stack block to ensure that it always run after the `vpc` stack. <https://terramate.io/docs/cli/stacks/configuration#explicit-order-of-execution>

```bash

stack {
  ...

  after = [
    "tag:vpc",
  ]
}
```

Check the order of execution

```bash
terramate list --run-order
```

### Proceed to the Next Step

Once you have completed Part 3, proceed to Part 4 by checking out the next tag:

```sh
git checkout part-4
```

Nice seeing you are still here .. 🖖🏼
