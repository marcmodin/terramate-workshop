# Part 1: Add Terramate to an Existing Terraform Project

In this section, you'll integrate Terramate into your existing Terraform setup and learn essential Terramate CLI commands.

## Instructions

Assume you a live Terraform production environment with resources deployed in one account across two regions. Let's see how easily Terramate can manage different states.

> [!WARNING]
> Since you will basically created a new git repository and included all branches, branches are considered unrelated and lack shared history between them. As such you need to `git merge main --allow-unrelated-histories` to merge main into the branch you are working on.

### Initialize Stacks

Initialize Terramate for all Terraform configurations: <https://terramate.io/docs/cli/reference/cmdline/create#import-existing-terraform-root-modules>.

```bash
terramate create --all-terraform
```

Check the generated `stack.tm.hcl` file in each VPC directory.

### List Stacks

List all stacks: <https://terramate.io/docs/cli/reference/cmdline/list>

```bash
terramate list
```

Add tags to the VPC stacks by updating the `stack.tm.hcl` so you can filter by tags later.

```hcl
stack {
  ...
  tags = [
    "euc1",
    "vpc"
  ]
}
```

Now, filter stacks by tags:

```bash
terramate list --tags euc1:vpc
```

### Create Stacks

Create a security groups stack:

```bash
terramate create live/prod/account-a/eu-north-1/security-groups
```

Clone the stack to another region:

```bash
terramate experimental clone live/prod/account-a/eu-north-1/security-groups live/prod/account-a/eu-central-1/security-groups
```

Add additional tags to the cloned stacks as needed.

### Order of Execution

Control the execution order of stacks. Ensure the `security-group` stack runs after the `vpc` stack by adding the `after` attribute. <https://terramate.io/docs/cli/stacks/configuration#explicit-order-of-execution>

```hcl
stack {
  ...
  after = [
    "tag:vpc",
  ]
}
```

Verify the execution order:

```bash
terramate list --run-order
```

### Change Detection

<https://terramate.io/docs/cli/change-detection/>

List changed stacks:

```bash
terramate list --changed 
```

Show the reason why a stack has changed:

```bash
terramate list --changed --why
```

### Run Commands

You can run any run any arbitrary command against all stacks: <https://terramate.io/docs/cli/reference/cmdline/run> not just terraform.

```bash
terramate run -- pwd
```

If you have untracked changes, [disabled safeguards](https://terramate.io/docs/cli/orchestration/safeguards) or commit your changes momentarily:

```bash
terramate run --disable-safeguards=all --changed -- pwd
```

Run commands on stacks with specific tags:

```bash
terramate run --tags aws:vpc --disable-safeguards=all -- pwd
```

#### Parallel Execution Built-in

<https://terramate.io/docs/cli/orchestration/parallel-execution#run-a-command-in-stacks-in-parallel>

Run the two vpc stacks in parallel, but before the security-groups

```bash
terramate run --disable-safeguards=all --parallel 2 -- pwd
```

## Next Step

After completing Part 1, proceed to Part 2:

```bash
git checkout part-2
```

Good luck! 🚀
