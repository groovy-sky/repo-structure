.PHONY: help validate validate-workflows

help:
	@echo "Available targets:"
	@echo "  validate            - basic local scaffold validation"
	@echo "  validate-workflows  - validate expected workflow scaffold files"

validate:
	@echo "Validating repository structure..."
	@test -d iac
	@test -d docker-images
	@test -d tools
	@test -d config
	@test -d docs
	@test -d artifacts
	@echo "Structure validation complete."

validate-workflows:
	@echo "Validating workflow scaffold files..."
	@for wf in \
		.github/workflows/validate.yml \
		.github/workflows/build-docker-images.yml \
		.github/workflows/scan-docker-images.yml \
		.github/workflows/terraform.yml \
		.github/workflows/pulumi.yml \
		.github/workflows/ansible.yml \
		.github/workflows/deploy.yml \
		.github/workflows/drift-detection.yml; do \
		test -f $$wf; \
	done
	@echo "Workflow scaffold validation complete."
