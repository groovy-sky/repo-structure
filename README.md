```
infrastructure/
├── README.md
│
├── iac/                         # Infrastructure definitions
│   ├── modules/                 # Reusable IaC components
│   │   ├── network/
│   │   ├── compute/
│   │   ├── database/
│   │   ├── storage/
│   │   └── monitoring/
│   │
│   ├── environments/            # Deployed infrastructure
│   │   ├── development/
│   │   ├── staging/
│   │   └── production/
│   │
│   └── README.md
│
├── docker/                      # Reproducible tool environment
│   ├── Dockerfile
│   ├── compose.yaml
│   ├── versions.env
│   ├── entrypoint.sh
│   └── README.md
│
├── scripts_and_tools/                     # Task-oriented automation
│   ├── setup/
│   ├── validation/
│   ├── planning/
│   ├── deployment/
│   ├── maintenance/
│   ├── reporting/
│   ├── libraries/
│   └── README.md
│
├── config/                      # Shared non-secret configuration
│   ├── linting/
│   ├── security/
│   ├── logging/
│   └── examples/
│
├── docs/                        # Human-readable documentation
│   ├── getting-started/
│   ├── architecture/
│   ├── operations/
│   ├── development/
│   ├── reference/
│   ├── decisions/
│   ├── diagrams/
│   └── README.md
│
├── artifacts/                   # Generated locally; usually ignored
│   ├── plans/
│   ├── reports/
│   └── logs/
│
├── .github/
│   ├── workflows/
│   │   ├── validate.yml
│   │   ├── test.yml
│   │   ├── plan.yml
│   │   ├── apply.yml
│   │   ├── drift-detection.yml
│   │   └── build-toolbox.yml
│   ├── CODEOWNERS
│   ├── dependabot.yml
│   └── pull_request_template.md
│
├── .dockerignore
├── .gitignore
└── .env.example
```

# Repository Structure Guide

This document explains each section of the infrastructure repository and its purpose.

## Root Level

### `.github/`
Contains GitHub-specific configuration and automation.

- **`workflows/`** — GitHub Actions CI/CD pipelines
  - `validate.yml` — Runs linting, syntax checks, and policy validation on all commits
  - `test.yml` — Executes infrastructure, script, and tool tests
  - `plan.yml` — Generates infrastructure change plans for review (terraform plan, pulumi preview, etc.)
  - `apply.yml` — Applies approved infrastructure changes to environments
  - `drift-detection.yml` — Periodic job detecting divergence between code and deployed state
  - `build-toolbox.yml` — Builds and publishes the Docker toolbox image

- **`CODEOWNERS`** — Defines code ownership and required reviewers by path
- **`dependabot.yml`** — Automated dependency update configuration
- **`pull_request_template.md`** — Template guiding PR authors with required sections and checks

### `.dockerignore`
Specifies files and directories excluded from Docker image builds (e.g., `.git`, `artifacts/`, `.env`).

### `.gitignore`
Excludes files from version control:
- Generated artifacts (`plans/`, `reports/`, `logs/`, `*.tfstate`)
- Local environment files (`.env`, `.env.local`)
- Temporary files and caches
- Secrets and credentials (never commit these)

### `.env.example`
Template showing required environment variables and configuration options. Users copy this to `.env` locally and populate with their values.

---

## `iac/` — Infrastructure-as-Code

Core infrastructure definitions using declarative IaC tools (Terraform, Pulumi, CloudFormation, etc.).

### `iac/modules/`
Reusable, composable infrastructure components following DRY principles.

- **`network/`** — VPCs, subnets, security groups, load balancers, NAT gateways
- **`compute/`** — EC2 instances, Kubernetes clusters, container orchestration, auto-scaling
- **`database/`** — RDS, DynamoDB, managed database services, backup policies
- **`storage/`** — S3 buckets, blob storage, object retention, encryption policies
- **`monitoring/`** — CloudWatch, Prometheus, logging pipelines, alerting rules

Each module:
- Is independently versioned and tested
- Accepts configuration via input variables
- Exports outputs for use by other modules
- Includes inline documentation of required and optional inputs

### `iac/environments/`
Environment-specific infrastructure deployments.

- **`development/`** — Minimal resources for development; rapid iteration, lower cost
- **`staging/`** — Production-like configuration; used for pre-release testing and validation
- **`production/`** — High-availability, disaster-recovery, security-hardened infrastructure

Each environment:
- References modules from `iac/modules/`
- Applies environment-specific variables (instance sizes, backup retention, replica counts)
- May include environment-specific resources (e.g., WAF rules for production only)
- Follows consistent naming conventions for resources

### `iac/README.md`
Documents:
- IaC tool setup and versioning
- Module structure and reuse patterns
- Environment configuration strategy
- State management and locking
- Common troubleshooting scenarios

---

## `docker/` — Reproducible Tool Environment

Ensures consistent toolchain versions and dependencies across all team members and CI/CD pipelines.

### `docker/Dockerfile`
Defines the container image with:
- Base OS image (typically lightweight Linux: Alpine, Debian)
- Required CLI tools (terraform, kubectl, aws-cli, gcloud, helm, ansible, etc.)
- Language runtimes (Python, Go, Node, etc.)
- Git, make, curl, jq, and other utilities

### `docker/compose.yaml`
Orchestrates local development environment:
- Mounts the repository into the container
- Sets up environment variable files
- Maps volumes for persistent data (e.g., Docker socket for nested Docker)
- Exposes necessary ports for local testing

---
## Cross-repository reusable workflow

A reusable workflow lets **Repo A run workflow logic stored in Repo B** without a PAT or custom secret.

```text
Repo A workflow → calls → Repo B reusable workflow
```

### Repo B: reusable workflow

`.github/workflows/deploy.yml`

```yaml
name: Deploy

on:
  workflow_call:
    inputs:
      environment:
        required: true
        type: string

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying to ${{ inputs.environment }}"
```

### Repo A: caller workflow

```yaml
name: Release

on:
  push:
    branches: [main]

jobs:
  deploy:
    uses: my-org/repo-b/.github/workflows/deploy.yml@main
    with:
      environment: staging
```

### Key points

- `workflow_call` makes Repo B’s workflow reusable.
- It must be called at the **job level**, not inside `steps`.
- Inputs work like function parameters.
- It creates **one workflow run in Repo A**, not a separate run in Repo B.
- For private Repo B, enable organization access under **Settings → Actions → General → Access**.
- Prefer a version tag or commit SHA instead of `@main` for stability:

```yaml
uses: my-org/repo-b/.github/workflows/deploy.yml@v1
```
