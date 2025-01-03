# Part 2: Refactor Terraform and Introduce Code Generation

In this section, you'll organize and refactor your Terraform codebase for better maintainability and scalability. You'll also use Terramate to dynamically generate Terraform configurations.

## Instructions

Assume you have a live Terraform production environment with multiple stacks deployed to one account across two regions. You need to centrally update Terraform and provider version constraints and ensure new stacks have correctly configured backends (state buckets don't exist yet).

---

Instead of statically defining files like `terraform.tf`, `providers.tf`, and `backend.tf`, you can generate them to simplify updates across a larger environment.

### Show Currently Calculated Values

View all values Terramate recognizes for each stack. Valid commands include `generate-origins`, `globals`, `metadata`, and `runtime-env`.

```bash
terramate debug show globals
terramate debug show metadata --tags aws:vpc
```

### Generate Configurations

<https://terramate.io/docs/cli/code-generation/generate-hcl>

In the `mixins` directory, you'll find files with `generate_hcl` blocks. Additionally, various config files represent `environment`, `account`, and `region` values used by Terramate to generate HCL. The global config `global.tm.hcl` is located at the root directory.

Include an import block in the global config or create a new `*.tm.hcl` file in the root:

```hcl
import {
    source = "/<directory>/*.tm.hcl"
}
```

Run the generate command and verify the newly created files:

```bash
terramate generate
```

> [!NOTE]
> In a real-world scenario, replace the old files with the generated new ones.

---

### Update Terraform Version

Update the required Terraform version and regenerate configurations:

```hcl
version = "1.9.5" > "1.10.0"
```

To update the version only in a specific region (e.g., `eu-north-1`), add the following to an existing `*.tm.hcl` or create a new config:

```hcl
# e.g., /live/prod/eu-north-1/region.tm.hcl

globals "terraform" {
  version = "1.10.0"
}
```

For advanced usage, explore the experimental `tmgen` feature or develop your own methods using generate. <https://terramate.io/docs/cli/code-generation/tmgen#example>

### Considerations

While Terramate's generate feature is powerful, you can introduce complexity and potential over-engineering. We like Terramate since it doesn't dictate how to you write or stucture your terraform unlike contemporary tools and would recommend a simplistic approach.

## Next Step

After completing Part 2, proceed to Part 3:

```bash
git checkout part-3
```

Great progress so far! 🚀
