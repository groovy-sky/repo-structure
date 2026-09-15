.PHONY: help validate validate-workflows

WORKFLOW_FILES := \
	validate.yml \
	build-docker-images.yml \
	scan-docker-images.yml \
	terraform.yml \
	pulumi.yml \
	ansible.yml \
	deploy.yml \
	drift-detection.yml

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
	@echo "Structure validation complete."

validate-workflows:
	@echo "Validating expected workflow scaffold files..."
	@test -d .github/workflows
	@for wf in $(WORKFLOW_FILES); do \
		test -f .github/workflows/$$wf; \
	done
	@echo "Workflow scaffold validation complete."
