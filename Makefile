.PHONY: help validate

help:
	@echo "Available targets:"
	@echo "  validate  - basic repository validation"

validate:
	@echo "Validating repository structure..."
	@test -d iac
	@test -d docker-images
	@test -d tools
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
	@echo "Structure validation complete."
