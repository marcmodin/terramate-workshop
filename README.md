# Terramate Workshop

Welcome to the Terramate Workshop! This workshop is designed to guide you through the essentials of using Terramate to manage Terraform at scale.

You will learn how to add Terramate to an existing Terraform project, refactor Terraform configurations, generate Terraform code with Terramate, and orchestrate a multi-region Terraform monorepo. By the end of this workshop, you will have a fully functioning setup with pull requests and GitHub Actions workflows.

To learn more about Terramate head over to their website <https://terramate.io>

## Workshop Overview

In this workshop, you will:

1. **Add Terramate to an Existing Terraform Project**: Learn how to integrate Terramate into your current Terraform setup.

2. **Refactor Terraform and Introduce Code Generation**: Organize and refactor your Terraform codebase for better maintainability and scalability, and use Terramate to generate Terraform configurations dynamically.

3. **Orchestrate a Multi-Account Monorepo with Code Generation and Reusable Modules**: Set up a large-scale Terraform monorepo that spans multiple AWS accounts, leveraging Terramate's powerful orchestration capabilities and reusable modules.

4. **Implement CI/CD with GitHub Actions**: Integrate your Terraform workflows with GitHub Actions to automate testing, validation, and deployment through pull requests.

> [!NOTE]
> Each step of the workshop includes detailed instructions (`docs/`) and examples to help you understand and apply the concepts effectively. Whether you are new to Terramate or looking to enhance your Terraform management skills, this workshop will provide you with the knowledge and tools you need to succeed.

## How to Follow the Workshop

To ensure that each participant has the correct structure to complete each step, the required files and directories for each part of the workshop are contained in their own branch within the git repository.

1. **Use this template**

    This repository is a template and you need to create a new repository in your own Gitub account based on it, [creating-a-repository-from-a-template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template).

> [!IMPORTANT]
> Make sure that you select `Include all branches` to include the directory structure and files from all branches in the template.

2. **Setup your Development environment**:

    You have a couple of options when it comes to setting up a working development environment required to run this workshop.
    1. Install terraform, terramate on directly on your host machine (*if you havent already*) 🙈
    2. Setup using Devbox using the included `devbox.json` file. [Getting started with Devbox](https://www.jetify.com/docs/devbox/quickstart/) 🖖🏼
    3. Run in a DevContainer using the included `.devcontainer/devcontainer.json` and `Dockerfile` in VSCode or using a tool like [Devpod](https://devpod.sh/docs/getting-started/install) (*advanced usage - requiring a container runtime installed and more configuration*) 🐳

3. **Ensure that you have access to an AWS Account**

To switch to the appropriate branch for each part of the workshop, use the following commands:

4. **Add Terramate to an Existing Terraform Project**:

    ```sh
    git checkout workshop/part-1
    ```

5. **Refactor Terraform and Introduce Code Generation**:

    ```sh
    git checkout workshop/part-2
    ```

6. **Orchestrate a Multi-Account Monorepo with Code Generation and Reusable Modules**:

    ```sh
    git checkout workshop/part-3
    ```

7. **Implement CI/CD with GitHub Actions**:

    ```sh
    git checkout workshop/part-4
    ```

> [!IMPORTANT]
> Parts 3 and 4 relates to each other, requires you to merge you changes and create actual pull-requests.

Each branch contains the necessary files and directory structure for that part of the workshop. Follow the instructions provided in each part to complete the workshop successfully.

Let's get started! 🚀
