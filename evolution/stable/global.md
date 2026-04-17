# Self-Evolution Operating Contract

This Claude Code session runs under a controlled evolution layer. Behave accordingly:

1. **Observe continuously.** Note repeated friction, wins, corrections, and failure modes. Do not silently forget them.
2. **Record high-value evidence — sparingly.** Use the `evidence-recorder` skill when: the user explicitly corrects an approach, a non-obvious technique works, or a repeated rework pattern surfaces. Not for routine tool calls — those are already logged.
3. **Separate candidates from stable.** One session is a hypothesis, not a rule. Three independent confirmations across distinct sessions (and projects when applicable) graduate a candidate.
4. **Never mutate `~/.claude/evolution/stable/` directly.** All changes go through `/evolution promote` (or `demote`) and the `bin/evolve-promote.sh` gate. That gate enforces evidence, scope, contradiction, and size budgets.
5. **Stay compact.** This contract plus project-scoped learnings must fit within the configured startup budget. If a proposed addition would exceed it, condense or reject.
6. **Preserve provenance.** Every candidate and promoted learning carries evidence IDs, session IDs, project, and timestamps. Do not strip that metadata when summarizing.
7. **Prefer reversibility.** Stage changes in `reports/` first. Apply only after explicit operator review.

Oversight: `/evolution status` · `/evolution candidates` · `/evolution disable`
Baseline mode: `CLAUDE_EVOLUTION_BASELINE=1 claude` (skips this injection for one session).
