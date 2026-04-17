---
description: "Controlled self-evolution oversight: status, candidates, promotions, regressions, prune, run, disable, enable, report."
argument-hint: "[status|candidates|promotions|regressions|prune|run|report|promote <id>|demote <id>|disable|enable|baseline]"
---

# /evolution — Controlled self-evolution oversight

Subcommand routing. `$ARGUMENTS` is the operator's arg string.

If no argument is supplied, default to `status`.

## Subcommands

### `status` (default)
Run: `bash ~/.claude/evolution/bin/evolve-status.sh`
Show output verbatim. This is the dashboard.

### `candidates`
List top candidates by confidence:
```bash
ls ~/.claude/evolution/candidates/*.yaml 2>/dev/null | while read f; do
  python3 -c "import yaml; d=yaml.safe_load(open('$f')); print(f\"{d['confidence']:.2f}  {d['evidence_count']}×  {d['id']}  — {d['summary']}\")"
done | sort -r | head -20
```
Then suggest: `/evolution promote <id>` for the top few if they look ready.

### `promotions`
Show the `reports/promoted-*.yaml` files (most recent 10):
```bash
ls -t ~/.claude/evolution/reports/promoted-*.yaml 2>/dev/null | head -10 | while read f; do
  python3 -c "import yaml; d=yaml.safe_load(open('$f')); print(f\"{d.get('promoted_at','?')}  {d['id']}  — {(d.get('proposed_text','') or '').strip()[:100]}\")"
done
```

### `regressions`
Run: `bash ~/.claude/evolution/bin/evolve-regression.sh`
Then display the resulting report.

### `prune`
Run: `bash ~/.claude/evolution/bin/evolve-prune.sh`
Then display the resulting report.

### `run`
Dispatch the `evolution-orchestrator` agent. Let it coordinate the full loop.

### `report`
Use the `session-analyst` skill to produce an end-of-session report.

### `promote <id>`
Use the `promotion-gate` skill. Require operator confirmation before writing.

### `demote <id>`
Run: `bash ~/.claude/evolution/bin/evolve-demote.sh <id>`
Show the resulting stable/*.md diff.

### `disable`
```bash
touch ~/.claude/evolution/disabled
```
Explain: hook will no-op until the file is removed. `/evolution enable` to re-enable.

### `enable`
```bash
rm -f ~/.claude/evolution/disabled
sed -i.bak 's/^enabled: false$/enabled: true/' ~/.claude/evolution/config.yaml 2>/dev/null || true
```

### `baseline`
Print: "To run a baseline session without injection, launch Claude Code with `CLAUDE_EVOLUTION_BASELINE=1 claude`. That session only. No changes to config."

## Operator arguments

Parse `$ARGUMENTS`:
- First token = subcommand (case-insensitive).
- Remaining tokens = args to the subcommand.
- Empty → `status`.
- Unknown → show this list and exit.

## Kill switch (always visible)
At the top of every output, include a one-line banner:
- `[evolution: enabled]` or `[evolution: DISABLED]` (check for `~/.claude/evolution/disabled`).

## Do not
- Do not invent activity. If there are no records / no candidates / no promotions, say so plainly.
- Do not promote without running the gate.
- Do not write to `stable/` outside of `bin/evolve-promote.sh` and `bin/evolve-demote.sh`.
