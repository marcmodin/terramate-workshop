# Part 1: Add Terramate to an Existing Terraform Project

In this part, you will learn how to integrate Terramate into your current Terraform setup and the basic Terramate Cli commands.

## Instructions

Say you have a live terraform production environment, with resources deployed in two accounts over two regions. Lets see how easy it is to let `Terramate` manage the different states

#### Create Stacks

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

Add any other tags to the other stacks ...

#### Run Commands

<https://terramate.io/docs/cli/reference/cmdline/run>

Run an arbitary command agaist all stacks

```bash
terramate run -- pwd
```

Or just against stacks with certain tags

```bash
terramate run --tags aws:vpc -- pwd
```

---

### Proceed to the Next Step

Once you have completed Part 1, proceed to Part 2 by checking out the next tag:

```sh
git checkout part-2
```

Good luck .. 🚀
