# Escape Hatch and Integration Points

Purpose: Detailed bypass rules, logging expectations, and integration map for the operating framework.

## Escape Hatch

Sometimes the framework itself is the bottleneck. The user can explicitly request a bypass with:

- "Just do it"
- "Skip routing"
- "Emergency mode"
- "No framework needed"

## What Still Applies

Even in bypass mode, these are never skipped:

1. No fabrication: never invent results.
2. Security-first behavior: never commit secrets.
3. Verify before asserting: read before claiming.
4. Approval gates for T2/T3, destructive, secret-affecting, production, or irreversible actions.

## What Gets Streamlined

- Session header: skipped, implicit T1/Solo/Build unless risk indicates otherwise.
- Lane routing: skipped, go straight to action.
- Council: skipped unless risk requires it.
- Completion packet: abbreviated to summary and evidence.

## What Gets Logged

Every bypass is noted for the monthly `/retro`:

- What was bypassed and why.
- Whether the outcome was successful.
- Whether the bypass caused issues.

This informs whether the framework is too heavy for certain task types.

## Integration Points

This framework wraps existing tools instead of replacing them.

| Framework Concept | Implemented By |
|---|---|
| Session routing | `/start-task` command |
| Micro-level gates | `using-operating-framework` skill |
| Pre-implementation check | `confidence-check` skill |
| Completion standards | `/complete` command |
| Lane: Explore | `/sc:brainstorm`, `/sc:research` |
| Lane: Specify | `/spec`, `/bmad:prd` |
| Lane: Build | `/sc:build`, `/sc:implement` |
| Lane: Verify | `/sc:test`, `/review` |
| Lane: Ship | `/pr-prep`, `/sc:git` |
| Lane: Recover | `/debug`, `/sc:troubleshoot` |
| Council execution | `/sc:spawn` with domain grouping |
| Memory persistence | Memory system in `~/.claude/projects/*/memory/` |
| Metrics collection | `~/.claude/scripts/metrics_collector.sh` |
| Framework retro | `/retro` command |
| Session handoff | `/handoff` command |
| Setup validation | `~/.claude/scripts/validate_setup.sh` |
| Templates | `~/.claude/templates/*.md` |
