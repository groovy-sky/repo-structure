```markdown
# Infrastructure Automation

Infrastructure-as-code, Docker-based tooling, scripts, and documentation.

## Structure

```text
iac/       Infrastructure modules and environments
docker/    Reproducible toolchain and dependencies
scripts/   Setup, validation, planning, and deployment
tools/     Reusable utilities
docs/      Architecture and operational guidance
tests/     Infrastructure, script, and tool tests
.github/   GitHub Actions configuration
```

## Usage

```bash
make toolbox
make validate
make test
make plan ENV=development
make apply ENV=development
```
