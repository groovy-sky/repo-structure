.PHONY: help validate

help:
	@echo "Available targets:"
	@echo "  validate  - basic repository validation"

validate:
	@echo "Validating repository structure..."
	@test -d iac
	@test -d docker-images
	@test -d tools
	@test -d .github/workflows
	@echo "Structure validation complete."
