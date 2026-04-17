# One-command entrypoints. All targets are idempotent and POSIX-safe.
.PHONY: help inventory validate usage install-hook lint clean-logs

help:
	@echo "Targets:"
	@echo "  make inventory    Regenerate docs/INVENTORY.md from filesystem"
	@echo "  make validate     Run drift + frontmatter checks (exit 1 on failure)"
	@echo "  make usage        Analyze ~/.claude/usage.jsonl (last 30 days)"
	@echo "  make install-hook Echo the PreToolUse hook to add to settings.json"
	@echo "  make lint         Alias for validate"

inventory:
	@scripts/inventory.sh --md

validate:
	@scripts/validate.sh

lint: validate

usage:
	@scripts/analyze-usage.sh

install-hook:
	@echo 'Add this to settings.json under hooks.PreToolUse:'
	@echo '  { "matcher": "", "hooks": [ { "type": "command", "command": "~/.claude/hooks/usage-logger.sh" } ] }'
