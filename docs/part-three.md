# Part 3: Orchestrate a Multi-Account Monorepo with Code Generation and Reusable Modules

In this section, you'll work with a scalable Terraform monorepo, leveraging Terramate's orchestration capabilities. You'll create reusable modules with code generation and experience working with Terraform in a multi-region environment.

> [!IMPORTANT]
> Safeguards are enabled. Ensure you `git commit` your changes and work on your own repository. At the end of this part, you'll merge changes back to main to test Terramate's [change detection](https://terramate.io/docs/cli/change-detection/).

## Instructions

### Setup AWS Account Configuration

In order for you to run Terraform commands, update the `account_id` to an AWS account you own and set your AWS credentials with appropriate permissions.

```hcl
# live/prod/account-a/account.tm.hcl

globals "aws" {
  name       = "account-a"
  account_id = "YOUR_ACCOUNT_ID"
}
```

### Orchestration

Learn more about orchestration [here](https://terramate.io/docs/cli/orchestration/).

#### Bootstrap

1. **Configure Remote State Backend:**

   Ensure you have an S3 backend for remote state. The `live/prod/account-a/bootstrap` stack generates the module code. The `no-backend` tag in the stack config instructs `mixins/backend.tm.hcl` to ignore this stack until the backend is deployed.

  > [!WARNING]
  > Remember to update `account_id`

2. **Generate Module Code:**

   Use the experimental `tmgen` feature to generate remote-state modules. This feature is pre-configured in `terramate.tm.hcl`. <https://terramate.io/docs/cli/code-generation/tmgen#example>

   ```bash
   terramate generate
   git add .
   ```

#### Deploy Remote State

1. **Provision Remote State Bucket:**

   Deploy the remote state using orchestration scripts. <https://terramate.io/docs/cli/orchestration/scripts>

   ```bash
   terramate --chdir live/prod/account-a/bootstrap/remote-state run -- sh -c '
     terraform init &&
     terraform apply -input=false -auto-approve
   '
   ```

2. **Update Backend Configuration:**

   Remove the `no-backend` tag from the stack and regenerate the backend configuration.

   ```bash
   terramate generate
   ```

3. **Reinitialize Terraform:**

   Push the state to the newly created S3 backend.

   ```bash
   terramate --chdir live/prod/account-a/bootstrap/remote-state run -- terraform init -migrate-state

   git add .
   git commit -m "feat: deploy remote-state bucket to prod account-a"
   ```  

  > [!TIP]
  > Consider creating a Terramate script to automate bucket creation, tag removal, backend generation, and state reinitialization 🧠

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

### Initialize and Deploy Other Stacks

1. **Initialize All Other Stacks:**

   Initialize all stacks except the `bootstrap` stack to prepare them for deployment.

   ```bash
   terramate --no-tags bootstrap run -- terraform init
   ```

2. **Plan and Apply All Other Stacks:**

   Execute a Terraform plan and apply for all stacks except `bootstrap`.

   ```bash
   terramate --no-tags bootstrap run -- terraform plan
   terramate --no-tags bootstrap run -- terraform apply -auto-approve
   ```

3. **Commit and Merge Changes Back to Main:**

   After successfully deploying, commit your changes and merge them back to the main branch to ensure the remote repository is up-to-date.

   ```bash
   git add .
   git commit -m "chore: initialize and deploy all stacks except bootstrap"
   git checkout main
   git merge your-feature-branch
   ```

### Test Change Detection

1. **Add a New Stack:**

   To test Terramate's change detection, add a new stack to your monorepo.

   ```bash
   terramate create live/prod/account-a/eu-north-1/ec2
   ```

2. **List Changed Stacks:**

   Verify that Terramate detects the newly added stack.

   ```bash
   terramate list --changed
   ```

   You should see the new stack listed as changed, indicating that Terramate recognizes the addition. You won't need this stack so you can undo your changes before continuing.

3. **Apply the stack and commit and merge your changes back to main**

## Next Step

After completing Part 3, proceed to Part 4:

```bash
git checkout workshop/part-4
```

Great job making it this far! 🖖🏼
