# One-command entrypoints. All targets are idempotent and POSIX-safe.
.PHONY: help inventory validate usage lint evolve-test evolve-status

help:
	@echo "Targets:"
	@echo "  make inventory      Regenerate docs/INVENTORY.md from filesystem"
	@echo "  make validate       Run drift + frontmatter + evolution checks"
	@echo "  make usage          Analyze ~/.claude/usage.jsonl"
	@echo "  make evolve-test    Smoke-test the evolution layer"
	@echo "  make evolve-status  Evolution dashboard"
	@echo "  make lint           Alias for validate"

inventory:
	@scripts/inventory.sh --md

validate:
	@scripts/validate.sh

lint: validate

usage:
	@scripts/analyze-usage.sh

evolve-test:
	@bash evolution/tests/smoke.sh

evolve-status:
	@bash evolution/bin/evolve-status.sh
