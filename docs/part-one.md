# Part 1: Add Terramate to an Existing Terraform Project

In this part, you will learn how to integrate Terramate into your current Terraform setup and the basic Terramate Cli commands.

## Instructions

Say you have a live terraform production environment, with resources deployed in one account over two regions. Lets see how easy it is to let `Terramate` manage the different states

#### Initilize Stacks

<https://terramate.io/docs/cli/reference/cmdline/create>

```bash
terramate create --all-terraform
```

See the generated `stack.tm.hcl` file in each vpc directory

#### List Stacks

<https://terramate.io/docs/cli/reference/cmdline/list>

List all Stacks

```bash
terramate list
```

Add tags to the VPC Stacks

```hcl
stack {
  ...
  tags = [
    "aws",
    "vpc"
  ]
}
```

Now you can list Stacks by Tags

```bash
terramate list --tags aws:vpc
```

#### Create Stacks

Create a security groups stack

```bash
terramate create live/prod/account-a/eu-north-1/security-groups 
```

Clone the stack to another region

```bash
terramate experimental clone live/prod/account-a/eu-north-1/security-groups live/prod/account-a/eu-central-1/security-groups
```

Add any other tags to the other stacks ...

#### Run Commands

<https://terramate.io/docs/cli/reference/cmdline/run>

Run an arbitary command agaist all stacks

```bash
terramate run -- pwd 
```

Since its most likely that you have made changes that are uncommitted and untracked you will need to run these commands with [disabled safeguards](https://terramate.io/docs/cli/orchestration/safeguards) or just commit your changes.

```bash
terramate run --disable-safeguards=all -- pwd
```

You can also run against stacks with certain tags

```bash
terramate run --tags aws:vpc --disable-safeguards=all -- pwd
```

The most useful feature is the ability to run against stacks that only have actually been changed

```bash
terramate run --disable-safeguards=all --changed -- pwd
```

This feature is hard to present unless you actually commit and push changes to the main branch. You can see that there are unmerged changes like so.

```bash
terramate list --changed --why
```

---

### Proceed to the Next Step

Once you have completed Part 1, proceed to Part 2 by checking out the next tag:

```sh
git checkout part-2
```

Good luck .. 🚀
