# Part 1: Add Terramate to an Existing Terraform Project

<<<<<<< HEAD
In this part, you will learn how to integrate Terramate into your current Terraform setup and the basic Terramate Cli commands.

## Instructions

Say you have a live terraform production environment, with resources deployed in one account over two regions. Lets see how easy it is to let `Terramate` manage the different states

#### Initilize Stacks

<https://terramate.io/docs/cli/reference/cmdline/create>
=======
In this section, you'll integrate Terramate into your existing Terraform setup and learn essential Terramate CLI commands.

## Instructions

Assume you have a live Terraform production environment with resources deployed in one account across two regions. Let's see how easily Terramate can manage different states.

### Initialize Stacks

Initialize Terramate for all Terraform configurations: <https://terramate.io/docs/cli/reference/cmdline/create>
>>>>>>> main

```bash
terramate create --all-terraform
```

<<<<<<< HEAD
See the generated `stack.tm.hcl` file in each vpc directory

#### List Stacks

<https://terramate.io/docs/cli/reference/cmdline/list>

List all Stacks
=======
Check the generated `stack.tm.hcl` file in each VPC directory.

### List Stacks

List all stacks: <https://terramate.io/docs/cli/reference/cmdline/list>
>>>>>>> main

```bash
terramate list
```

<<<<<<< HEAD
Add tags to the VPC Stacks
=======
Add tags to the VPC stacks by updating the `stack.tm.hcl`:
>>>>>>> main

```hcl
stack {
  ...
  tags = [
    "aws",
    "vpc"
  ]
}
```

<<<<<<< HEAD
Now you can list Stacks by Tags
=======
Now, filter stacks by tags:
>>>>>>> main

```bash
terramate list --tags aws:vpc
```

<<<<<<< HEAD
#### Create Stacks

Create a security groups stack

```bash
terramate create live/prod/account-a/eu-north-1/security-groups 
```

Clone the stack to another region
=======
### Create Stacks

Create a security groups stack:

```bash
terramate create live/prod/account-a/eu-north-1/security-groups
```

Clone the stack to another region:
>>>>>>> main

```bash
terramate experimental clone live/prod/account-a/eu-north-1/security-groups live/prod/account-a/eu-central-1/security-groups
```

<<<<<<< HEAD
Add any other tags to the other stacks ...

#### Run Commands

<https://terramate.io/docs/cli/reference/cmdline/run>

Run an arbitary command agaist all stacks

```bash
terramate run -- pwd 
```

Since its most likely that you have made changes that are uncommitted and untracked you will need to run these commands with [disabled safeguards](https://terramate.io/docs/cli/orchestration/safeguards) or just commit your changes.
=======
Add additional tags to the cloned stacks as needed.

### Run Commands

Run an arbitrary command against all stacks: <https://terramate.io/docs/cli/reference/cmdline/run>

```bash
terramate run -- pwd
```

If you have untracked changes, [disabled safeguards](https://terramate.io/docs/cli/orchestration/safeguards) or add your changes momentarily:
>>>>>>> main

```bash
terramate run --disable-safeguards=all -- pwd
```

<<<<<<< HEAD
You can also run against stacks with certain tags
=======
Run commands on stacks with specific tags:
>>>>>>> main

```bash
terramate run --tags aws:vpc --disable-safeguards=all -- pwd
```

<<<<<<< HEAD
The most useful feature is the ability to run against stacks that only have actually been changed
=======
Run commands only on changed stacks:
>>>>>>> main

```bash
terramate run --disable-safeguards=all --changed -- pwd
```

<<<<<<< HEAD
This feature is hard to present unless you actually commit and push changes to the main branch. You can see that there are unmerged changes like so. You will explore changed stacks in a later part.
=======
View unmerged changes:
>>>>>>> main

```bash
terramate list --changed --why
```

<<<<<<< HEAD
---

### Proceed to the Next Step

Once you have completed Part 1, proceed to Part 2 by checking out the next tag:

```sh
git checkout part-2
```

Good luck .. 🚀
=======
## Next Step

After completing Part 1, proceed to Part 2:

```bash
git checkout part-2
```

Good luck! 🚀
>>>>>>> main
