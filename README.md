# Infrastructure Repository Structure

This repository is organized for infrastructure-as-code, container image definitions, CI workflows, and operational documentation.

## Top-level layout

- `iac/` — Terraform, Pulumi, and Ansible source layouts.
- `docker-images/` — Dockerfiles, shared image assets, and local compose definitions.
- `tools/` — Utility scripts and supporting code used by this repository.
- `config/` — Non-secret shared configuration.
- `docs/` — Documentation and runbooks.
- `artifacts/` — Local generated output (tracked only with a placeholder).
- `.github/` — GitHub Actions resources, including `.github/workflows/` scaffolding and reusable actions.

Current workflow files are placeholders for future automation. `make validate` checks the core local scaffold subset (`iac`, `docker-images`, `tools`, `config`, `docs`, `.github`). `artifacts/` is intentionally excluded because it holds local outputs. `.github/workflows/` and expected workflow placeholder files are checked via `make validate-workflows`.
