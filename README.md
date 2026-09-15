```
infrastructure/
├── README.md
├── Makefile
│
├── iac/
│   ├── terraform/
│   │   ├── modules/
│   │   ├── stacks/
│   │   └── bootstrap/
│   ├── pulumi/
│   │   ├── components/
│   │   └── projects/
│   └── ansible/
│       ├── collections/
│       ├── playbooks/
│       └── inventories/
│
├── docker-images/
│   ├── github-runners/
│   │   ├── base/
│   │   ├── iac/
│   │   └── build/
│   ├── iac-tools/
│   │   ├── terraform/
│   │   ├── pulumi/
│   │   ├── ansible/
│   │   └── toolbox/
│   ├── shared/
│   ├── compose.yaml
│   └── README.md
│
├── automation/
│   ├── bin/
│   ├── lib/
│   └── tests/
│
├── config/
├── policies/
├── docs/
├── artifacts/
│
└── .github/
    ├── actions/
    └── workflows/
        ├── validate.yml
        ├── build-docker-images.yml
        ├── scan-docker-images.yml
        ├── terraform.yml
        ├── pulumi.yml
        ├── ansible.yml
        ├── deploy.yml
        └── drift-detection.yml
```


* README.md — Repository overview, prerequisites, architecture summary, and common usage instructions.
* Makefile — Consistent commands for validation, testing, image builds, planning, and deployment.
* CONTRIBUTING.md — Contribution process, coding standards, testing requirements, and pull request guidelines.
* SECURITY.md — Security reporting process and repository-specific security practices.
* .editorconfig — Common formatting rules across editors and file types.
* .env.example — Example environment variables required for local development; contains no real secrets.
* .gitignore — Excludes generated files, local configuration, state, plans, logs, caches, and secrets.
* .dockerignore — Excludes unnecessary or sensitive files from Docker build contexts.
* iac/ — Terraform, Pulumi, and Ansible infrastructure definitions, organized using tool-specific layouts.
* docker-images/ — Docker image definitions for GitHub runners, IaC tools, build environments, and shared base images.
* automation/ — Scripts, commands, shared libraries, and tests used to automate repository tasks.
* config/ — Shared, non-secret configuration for linting, logging, security tools, and local development.
* policies/ — Policy-as-code rules and approved exceptions for infrastructure, containers, and CI/CD.
* docs/ — Architecture documentation, operational guides, decisions, runbooks, and diagrams.
* artifacts/ — Locally generated plans, previews, logs, and reports; normally excluded from version control.
* .github/ — GitHub Actions workflows, reusable actions, ownership rules, and pull request configuration.
