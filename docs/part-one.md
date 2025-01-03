# Part 1: Add Terramate to an Existing Terraform Project

In this section, you'll integrate Terramate into your existing Terraform setup and learn essential Terramate CLI commands.

## Instructions

Assume you a live Terraform production environment with resources deployed in one account across two regions. Let's see how easily Terramate can manage different states.

### Initialize Stacks

Initialize Terramate for all Terraform configurations: <https://terramate.io/docs/cli/reference/cmdline/create>

```bash
terramate create --all-terraform
```

Check the generated `stack.tm.hcl` file in each VPC directory.

### List Stacks

List all stacks: <https://terramate.io/docs/cli/reference/cmdline/list>

```bash
terramate list
```

Add tags to the VPC stacks by updating the `stack.tm.hcl`:

```hcl
stack {
  ...
  tags = [
    "aws",
    "vpc"
  ]
}
```

Now, filter stacks by tags:

```bash
terramate list --tags aws:vpc
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

### Run Commands

Run an arbitrary command against all stacks: <https://terramate.io/docs/cli/reference/cmdline/run>

```bash
terramate run -- pwd
```

If you have untracked changes, [disabled safeguards](https://terramate.io/docs/cli/orchestration/safeguards) or add your changes momentarily:

```bash
terramate run --disable-safeguards=all -- pwd
```

Run commands on stacks with specific tags:

```bash
terramate run --tags aws:vpc --disable-safeguards=all -- pwd
```

Run commands only on changed stacks:

```bash
terramate run --disable-safeguards=all --changed -- pwd
```

View unmerged changes:

```bash
terramate list --changed --why
```

## Next Step

After completing Part 1, proceed to Part 2:

```bash
git checkout part-2
```

Good luck! 🚀
