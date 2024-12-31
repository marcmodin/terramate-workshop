# Part 2: Refactor Terraform and Introduce Code Generation

In this part, you will organize and refactor your Terraform codebase for better maintainability and scalability, and use Terramate to generate Terraform configurations dynamically.

## Instructions

Imagine you have a live terraform production environment, with mulitiple stacks deployed to one account over two regions. You need to ensure that terraform and provider version constraints can be centrally updated and that new stacks will have correctly configured backends (the state bucket don't exist yet).

---

There are a few files that we could potentially generate instead having them statically defined. `terraform.tf` which includes the required terraform version, `providers.tf` and the `backend.tf`.

If you have a look at those files you can see how cumbersome it would be in a large environement to update them everywhere.

#### Show Currently Calculated Values

You can view all values terramate will know about for each stack. Valid commands `generate-origins`, `globals`, `metadata`, `runtime-env` <https://terramate.io/docs/cli/reference/cmdline/debug/show/debug-show-globals>

```bash
terramate debug show globals
terramate debug show metadata --tags aws:vpc
```

#### Generate

Included in the `mixins` directory are a couple of files that contains `generate_hcl` block. <https://terramate.io/docs/cli/code-generation/generate-hcl>

You will also find various config files representing `environment`, `account` and `region` values that will be used when terramate generates hcl, as well as global config `global.tm.hcl` at the root of the directory (terramate doesnt dictate how to stucture your configurations, unlike terragrunt).

You need to include an import block in the global config (or create a new `*.tm.hcl` file in root)

```bash
import {
    # import all files in a directory
    source = "/imports/*.tm.hcl"
}
```

Run generate and check the newly created files.

```bash
terramate generate
```

> In a real world scenario you would ofc remove the old files after generating new ones.
---

Generate is pretty powerful, but could potentially become a cause of complexity and over-engineering. Eg. you could also explore the experimental feature `tmgen` <https://terramate.io/docs/cli/code-generation/tmgen#example> or figure out how to share common values files.

### Proceed to the Next Step

Once you have completed Part 2, proceed to Part 3 by checking out the next tag:

```sh
git checkout part-3
```

Great progress so far .. 🚀
