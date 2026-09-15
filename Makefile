.PHONY: help validate validate-workflows

help:
	@echo "Available targets:"
	@echo "  validate            - basic local scaffold validation"
	@echo "  validate-workflows  - validate workflow scaffold presence"

validate:
	@echo "Validating repository structure..."
	@test -d iac
	@test -d docker-images
	@test -d tools
	@test -d config
	@test -d docs
	@echo "Structure validation complete."

validate-workflows:
	@echo "Validating workflow scaffold presence..."
	@test -d .github/workflows
	@test "$$(find .github/workflows -maxdepth 1 -type f -name '*.yml' | wc -l)" -ge 1
	@echo "Workflow scaffold validation complete."
