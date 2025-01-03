# Part 4: Implement CI/CD with GitHub Actions

In this section, you'll manage your Terraform environment by adding new stacks, opening a pull-request, and using GitHub Actions allowing Terramate to perform plan and apply only on changed stacks. This automation ensures that your infrastructure updates are efficiently tested and deployed.

> [!IMPORTANT]
> Safeguards are enabled. Ensure you `git commit` your changes and work on your own repository. At the end of this part, you'll merge changes back to main to test Terramate's [change detection](https://terramate.io/docs/cli/change-detection/).

## Instructions

### Update Your Branch with Main

Before starting Part 4, ensure your feature branch is up-to-date with the latest changes from the `main` branch.

```bash
git merge main
```

### Review Workflow Files

Begin by reviewing the existing GitHub Actions workflow file located at `.github/workflows/plan.yml`.

### Explanation of Plan Workflow Steps

The plan workflow includes the following steps:

```yaml
- Checkout Repository: Retrieves the latest code from the repository.
- Install Dependencies: Installs required dependencies defined in 'devbox.json'
- Configure AWS Credentials: Sets up AWS credentials using secrets or OIDC.
- Terramate Init: Initializes Terraform with Terramate orchestration.
- Terramate Plan: Creates an execution plan for Terraform changes.
```

### Explanation of Apply Workflow Steps

The apply workflow is triggered when changes are merged to main. The steps are nearly identical to the plan workflow with one addition.

```yaml
- Terramate Apply: Applies the Terraform changes automatically on pushes to the `main` branch.
```

### Configure AWS Secrets or OIDC Provider

#### Using AWS Secrets

1. Navigate to Repository Settings:
   - Go to your GitHub repository.
   - Click on **Settings** > **Secrets and variables** > **Actions**.

2. Add AWS Secrets:
   - Click **New repository secret**.
   - Add the following secrets:
     - `AWS_ACCESS_KEY_ID`
     - `AWS_SECRET_ACCESS_KEY`

3. Use Secrets in Workflow:
   - The workflow file references these secrets to configure AWS credentials.

   ```yaml
   - name: Configure AWS Credentials
     uses: aws-actions/configure-aws-credentials@v2
     with:
       aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
       aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
       aws-region: eu-north-1
   ```

#### Using OIDC Provider

If you prefer using an OpenID Connect (OIDC) provider for enhanced security:

1. **Set Up OIDC Provider:**

- Create the Github OIDC provider using a terraform module <https://github.com/playgroundtech/terraform-aws-github-actions-oidc>
- Or follow the [AWS OIDC setup guide](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) to manually configure your OIDC provider with GitHub.

2. **Update Workflow for OIDC:**
   - Modify the workflow to use OIDC for authentication instead of AWS secrets.

   ```yaml
   - name: Configure AWS Credentials with OIDC
     uses: aws-actions/configure-aws-credentials@v2
     with:
       role-to-assume: arn:aws:iam::YOUR_ACCOUNT_ID:role/YOUR_ROLE
       aws-region: eu-north-1
   ```

   - Commit your changes

---

### Terramate Scenario

Assuming that you are managing multiple Terraform stacks across different environments and regions. Terramate simplifies this by orchestrating actions only on the stacks that have changed. Ensure that Github Actions use change-detection to plan and apply.

### Add a New Stack

Create a new stack anywhere you like or clone an existing one.

```bash
terramate create live/prod/eu-central-1/ec2
```

### 1. Generate the Code

Generate the necessary Terraform configurations using Terramate.

```bash
terramate generate
```

### 2. Review Changed Stacks

Verify that only the new changes are detected by listing the changed stacks.

```bash
terramate list --changed
```

### 3. Add and Commit Changes, Create Pull Request

Commit your changes and push them to your feature branch. Then, create a pull request to merge your changes into the `main` branch.

```bash
git add .
git commit -m "chore: add new EC2 stack in eu-central-1"
git push origin your-feature-branch
```

1. **Create Pull Request:**
   - Navigate to your repository on GitHub.
   - Click **Compare & pull request** for your feature branch.
   - Fill in the pull request details and submit it.

2. **GitHub Actions Workflow:**
   - The workflow will automatically run on the pull request, performing Terramate and Terraform operations.
   - Monitor the **Actions** tab to ensure the workflow completes successfully.

### 4. Approve and Merge Pull Request

Once the GitHub Actions workflow succeeds:

1. **Review Changes:**
   - Ensure all checks have passed.
   - Review the Terraform plan.

2. **Approve Pull Request:**
   - Approve the pull request if everything looks correct.

3. **Merge Pull Request:**
   - Merge the pull request to apply the changes to the `main` branch.
   - The workflow will trigger again to apply the Terraform changes automatically.
4. **You are done!**

---

### Next Steps

We have worked with a pretty simple example, but you could take this further. There is alot more to cover and we encourage you to explore the rest of the [Terramate docs](https://terramate.io/docs).

Terramate opensource is pretty powerful tool as is. However they offer a cloud solution that takes infrastructure as code management to a whole other level. <https://terramate.io/docs/how-it-works>

---

Great job completing the workshop! 🚀 Keep building and automating your infrastructure with Terramate and Terraform.
