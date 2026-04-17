# RUNBOOK — Common Workflows

_Quick-reference playbook for the 10 most-common operations in this setup. Each entry is a short recipe; deeper rationale lives in the referenced skill / command files._

## 1. Start a new coding task

```
/start-task
```

or, for a complete feature end-to-end:

```
/ship <one-line description>
```

Behind the scenes: `/plan` runs Stages 1-3 (parse → context → route), then `/ship` enforces Elite Ops completion criteria. Max 3 parallel subagents. T2+ actions pause for your approval.

## 2. Debug a production issue

```
/fix-root <one-line symptom>
```

Enforces root-cause-first: investigation → hypothesis → evidence → narrow patch → regression protection. See `skills/debugger` + `agents/debugger.md`. If the cause is obvious and the fix is one-liner, use `/debug` instead.

## 3. Review code before merge

```
/review            # bare code review
/council-review    # pressure-test with multi-perspective panel
/pr-prep           # final gate before git push
```

Full disambiguation in [`docs/SURFACE-MAP.md`](./SURFACE-MAP.md) § "Inspect something".

## 4. Research a new technology

```
/recall <query>    # check prior conversations (claude-mem + conversation grep)
/wiki-query <q>    # check the curated KB
```

or dispatch the `deep-research` agent for a multi-hop investigation. If the topic is truly novel, use the `research-methodology` skill.

If you find reusable material, ingest it:

```
# drop notes into kb/raw/, then:
/wiki-ingest
```

## 5. Analyze a finance opportunity

Routes through `domains/finance/DOMAIN.md`. Typical flow:

```
# Portfolio risk metrics:
invoke `wshobson-SKILL` — VaR, CVaR, Sharpe, Sortino, drawdown

# Price forecasting:
invoke `timesfm-forecasting` or `finance-ml`

# Market scan (requires aster MCP — currently Tier-3 aspirational):
recipes/trading/market-scan.yaml

# Valuation / DCF:
invoke `financial-modeling` or `financial-analyst`
```

Live trading recipes are MCP-gated. Without the `aster` MCP installed, trading skills operate in offline-fixture mode only.

## 6. Plan a marketing campaign

Routes through `domains/marketing/DOMAIN.md`. Entry point:

```
/market audit    # analyze current state — full audit via 5 subagents
/market launch   # generate launch playbook with week-by-week tactics
```

Sub-workflows: `/market copy`, `/market emails`, `/market social`, `/market ads`, `/market funnel`, `/market landing`, `/market proposal`. See `skills/market/SKILL.md`.

For strategic framing at the CMO level, invoke `cmo-advisor` via the `business-panel-experts` agent.

## 7. Deploy to production

```
recipes/devops/deploy-check.yaml    # deploy gate via devops-architect → ci-cd-engineer
```

Prerequisites: green CI, no uncommitted changes (enforced by `hooks/stop-verification.sh`), security scan passes. For releases specifically:

```
invoke `release-engineer` agent with `release-automation` skill
```

Uses Release Please, Renovate, conventional commits, semver.

## 8. Add a new skill

```
1. Copy skills/_shared/skill-template.md to skills/<your-skill>/SKILL.md
2. Fill in frontmatter per skills/_shared/naming-conventions.md
3. Run through skills/_shared/review-checklist.md
4. If the skill has a canonical intent in docs/SURFACE-MAP.md, add it there
5. If it belongs to a domain, reference it from domains/{domain}/{subdomain}/SUBDOMAIN.md
6. make inventory && make validate
```

The `skill-creator` skill automates steps 1-3 interactively. For design-language skills specifically, use the `hue` meta-skill which generates brand-specific child skills.

## 9. Run self-improvement

```
/improve [target]
```

Refines a skill / agent / command / hook / doc based on recent evidence. If there's ≥7 days of `~/.claude/usage.jsonl`, telemetry-informed; otherwise cross-refs + self-evolution records only. See `commands/improve.md`.

Related:

```
/evolution status     # self-evolution layer status
/evolution disable    # kill switch
/wiki-lint            # KB health check
```

## 10. Recover from a failed task

Priorities in order:

1. **Don't destroy state** — no `git reset --hard`, no `rm -rf` of working files.
2. **Capture evidence** — check `~/.claude/history.jsonl` and `memory/session-history.md` for the last-known-good state.
3. **Identify the root cause** — use `/fix-root` or the `root-cause-analyst` agent. Never patch a symptom without understanding the cause.
4. **Write a retrospective** — drop a file under `kb/retrospectives/YYYY-MM-DD-<what-failed>.md` using the template. Even if you're the only reader.
5. **Consider a candidate** — if the failure points to a durable rule change, add a YAML under `evolution/candidates/` per the self-evolution schema.

If the failure was in persistent / autonomous mode:

```
"cancel"  or  "stop mode"  or  "abort mode"
```

deactivates the mode. The Stop hook will no longer block session end.

---

## Cross-cutting concerns

### When in doubt about which command to pick

→ [`docs/SURFACE-MAP.md`](./SURFACE-MAP.md) has the canonical-per-intent routing table.

### When in doubt about which domain a task belongs to

→ Check the "Domain Map" section of [`CLAUDE.md`](../CLAUDE.md). Load the right `domains/{domain}/DOMAIN.md` on demand.

### When you need to check counts or drift

```
make inventory      # regenerate docs/INVENTORY.md
make validate       # drift + frontmatter + hook-ref checks
make usage          # telemetry analysis (needs ≥7 days of usage.jsonl)
```

### When something in ~/.claude/ looks suspicious

Backups exist:

- `~/.claude.backup.20260417/` — latest (pre-Phase-1 restructure)
- `~/.claude.backup/` — previous (2026-04-13)
- `~/.claude.bak.20260413/` — earlier still

Repo git history (`git log`) is also a safety net — the repo is a tracked source; `~/.claude/` is the runtime copy.

### When a Tier-3 MCP is needed

```
# Install steps for any of the 20 aspirational servers:
skills/mcp-mastery/SKILL.md

# Runtime gate that blocks unconnected MCP calls:
hooks/mcp-security-gate.sh
```

---

## Status

Phase 7 deliverable from the restructure. This file will grow as new workflows emerge — it's additive.
