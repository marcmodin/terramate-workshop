# Part 3: Orchestrate a Multi-Account Monorepo with Code Generation and Reusable Modules

In this part, you will set up a larger-scale Terraform monorepo that builds on part-2, leveraging Terramate's powerful orchestration capabilities, create reusable modules with code generation and see how its like to work with terraform.

From now on we will not disable safeguards which means you will need to git add your changes. At the end of this part you will merge your changes back to main so that we can test our Terramate's [change detection](https://terramate.io/docs/cli/change-detection/). That's why it is important that you are working off your own fork of this repository.

## Instructions

✅ If you plan to run terraform commands while following along, you will need to change the `account_id` to an account that you have access to, as well as setting your AWS credentials session with permissions for that account.

```bash
# live/prod/account-a/account.tm.hcl

globals "aws" {
  name       = "account-a"
  account_id = "?"
}
```

### Orchestration

<https://terramate.io/docs/cli/orchestration/>

#### Boostrap Remote State

You will need to have remote-state s3 backend to be able to run terraform commands with a remote-backend configuration.

The stack located in `live/prod/account-a/boostrap` generates the module code that you can deploy (remember to change the account_id).

Here we use an experimental feature `tmgen` (well, not so experimental anymore!). The experimental feature have already been added to `terramate.tm.hcl`. <https://terramate.io/docs/cli/code-generation/tmgen#example>

Review the `main.tf.tmgen` file and generate the code.

```bash
terramate generate
# add and commit changes
git add .
git commit -m "feat: deploy remote-state bucket to prod account-a"
```

Deploy the remote state bucket specifically using orchestration. <https://terramate.io/docs/cli/orchestration/scripts>

We can deploy the remote-state either using scripts or inline using the following command (-chdir can be replaced with --tags bootstrap:remote-state).

```bash
terramate --chdir live/prod/account-a/bootstrap/remote-state run -- sh -c '
  terraform init &&
  terraform apply -input=false -auto-approve
  '
```

> Thought! why not have a terramate script - which creates the bucket > removes the no-backend tag > generates _backend.tf and reinitializes the state using the new backend 🧠

#### Order of execution

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
