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

---

# AI OS — Operator Workflows

> The AIS-OS-style personal operating layer added in 2026-05-03 commit `<sha>`. Daily, weekly, and "what to do when something fails" recipes for the four-layer system: Warp · Claude Code · SocratiCode · this repo · AIS-OS context.

## First-time AI OS setup

If this is a fresh clone or a fresh machine:

1. **Open a terminal in the repo.** Warp is recommended — see `docs/WARP_COCKPIT.md` for layout suggestions and the privacy checklist.
2. **Run Claude Code:** `claude`
3. **Onboard the OS:** `/onboard`
   - 7-question intake. Privacy guard active — never paste credentials, customer PII, or your email into the answers.
   - Populates `context/`, seeds `connections.md` Tier-4 rows, logs the run in `decisions/log.md`.
4. **Review the connections roadmap** (`docs/CONNECTIONS_ROADMAP.md`) and decide your first 1-2 connections to wire.
5. **Run the first audit:** `/audit`
   - First-ever scores typically land 15-30/100. That's the baseline, not a verdict.
6. **Run the first level-up:** `/level-up`
   - One recommended next artifact. Don't build it yet — sit with it 24h.
7. **Build one small skill or script.** Use `references/skill-building-framework.md` as the pattern.

After this you have a baseline. The OS now has enough context to be useful.

## Daily

### Morning
```
/daily-plan
```
Reads `context/Priorities.md` + `kb/wiki/_hot.md` + last 7 days of `decisions/log.md`. Outputs three lines: top focus, AI-assisted task, what you're not doing today.

### Working
Use `/ship`, `/fix-root`, `/review`, `/test-gen`, etc. as needed. Each goes through this repo's hooks and MCP gates.

### Evening
```
/end-of-day-review
```
Five lines: what changed, what skills worked, what broke, context gap, tomorrow's hint. Logs to `decisions/log.md`.

## Weekly (Friday)

```
/weekly-operating-review
```

Combines:
- `/audit` — Four-Cs scorecard, top 3 gaps, recommended action
- `/level-up` — five reflection questions, one recommended artifact
- `_hot.md` refresh from current state

Or run them separately if you prefer.

The recommended artifact is for **next week** — don't build it Friday afternoon. Use the weekend to sit with whether it's the right thing.

## When a task fails

This is the failure-to-learning rule from `CLAUDE.md § AI OS Layered Architecture`:

1. **Ask why it failed.**
   - Missing context? (which `context/`, `references/`, or `kb/wiki/` file would have helped?)
   - Missing capability? (no skill / script / agent for this work?)
   - Bad skill step? (the skill ran but did the wrong thing?)
   - Unsafe assumption? (the code or data wasn't what the OS thought?)
2. **Update the relevant artifact.**
   - Missing context → add to the right file
   - Missing capability → add to `/level-up` candidates
   - Bad skill step → edit the skill (`skills/<name>/SKILL.md`)
   - Unsafe assumption → add a guard or validation step
3. **Log the decision** in `decisions/log.md` with date, root cause, and what you changed.
4. **Try again** with the updated system.

If the same failure recurs after the update → the update was wrong. Repeat the loop with a different fix.

## When a destructive command is blocked

The destructive command gate (inline in `settings.json`, plus extracted `hooks/destructive-command-gate.sh`) blocks force-pushes-without-lease and `rm -rf` on system paths. If you hit a block:

1. **Read the block message.** It tells you which pattern matched and why.
2. **Check intent.** Did you mean to do this? Often the block is correct.
3. **If the intent is genuine,** rephrase the command:
   - `git push --force` → `git push --force-with-lease`
   - `rm -rf /tmp/foo` → `rm -rf ./tmp/foo` (relative path)
4. **Never bypass with `--no-verify` or by editing the hook** without explicit deliberation. If the hook is over-blocking, propose an addition to the pattern in a separate commit.

## When SocratiCode is unavailable

SocratiCode is documented but not installed in the default state. Skills that prefer SocratiCode (`/ship`, `/audit-deep`, `/fix-root`) fall back gracefully via `skills/socraticode-preflight/SKILL.md`:

1. First fallback: `code-review-graph` MCP (already live)
2. Second fallback: `Grep` + `Read` + `git grep`

The skill logs which tool was actually used, so you can see the fallback in the output.

To install SocratiCode (requires explicit operator approval):
```
claude plugin marketplace add giancarloerra/socraticode
claude plugin install socraticode@socraticode
```

See `docs/SOCRATICODE.md` for full details.

## When a connection breaks

If an MCP server stops responding or a Direct API integration starts failing:

1. **Check `claude mcp list`** for MCP servers (auth status, connection health).
2. **Check `~/.claude/audit-mcp.log`** for the last successful call vs. the first failed call.
3. **Check the source** — has the credential expired? Has the API changed?
4. **Use the kill switch** (documented in `connections.md`) to disable the integration cleanly while you fix.
5. **Update the row** in `connections.md` to reflect status.
6. **Log in `decisions/log.md`** if the fix involves a credential rotation or schema change.

## When the AI OS feels "off"

If the OS routes wrong, suggests stale things, or generally feels disconnected:

1. **Check `kb/wiki/_hot.md`** — is it >7 days old? Run `/weekly-operating-review` to refresh.
2. **Check `context/Priorities.md`** — does it still reflect this week's reality? Edit directly or re-run `/onboard --quick`.
3. **Check `decisions/log.md`** last entries — has the OS been used? If the last 5 entries are >2 weeks old, the OS has been dormant.
4. **Run `/audit`** — the score and the top-3 gaps usually point at what's missing.
5. **If multiple things feel off,** schedule a quarterly review (refresh `Priorities.md`, prune `archives/`, re-baseline `connections.md`).

## Success criteria for the OS

You'll know the OS is working when:

1. **You ask the AI OS before opening many tabs** — the OS is the first stop, not the last.
2. **Knowledge leaves your head and lives in `context/`, `kb/wiki/`, `decisions/log.md`** — you can take a week off and the OS still knows what to do.
3. **Repeated work becomes skills/scripts** within 2-3 weeks of being noticed via `/level-up`.
4. **Your weekly `/audit` score trends up** over 4-6 weeks. Not monotonically — but the line goes up.
5. **The OS produces useful outputs even when you're not micromanaging** — `/daily-plan`, `/audit`, `/level-up` give you signal you wouldn't have otherwise.

If you're 30 days in and none of the above is true: the OS isn't working for you yet. Run `/audit` honestly, look at the lowest-scoring pillar, and consider whether the failing piece is worth fixing or whether to drop it. Not every operator needs every layer.

## Layer-specific quick references

| Need | Skill / doc |
|------|-------------|
| Operator mindset (Three Ms) | `references/3ms-framework.md` |
| System structure (Four Cs) | `references/four-cs-framework.md` |
| Skill-building pattern | `references/skill-building-framework.md` |
| API integration rules | `references/api-integration-principles.md` |
| Direct API vs MCP decision | `references/direct-api-vs-mcp.md` |
| Connections roadmap | `docs/CONNECTIONS_ROADMAP.md` |
| Cadence model | `docs/CADENCE.md` |
| Wiki layer + naming aliases | `docs/WIKI_LAYER.md` |
| SocratiCode integration | `docs/SOCRATICODE.md` |
| Warp cockpit setup | `docs/WARP_COCKPIT.md` |
| Warp workflow snippets | `docs/WARP_WORKFLOWS.md` |
| Security defence layers | `docs/SECURITY.md` |
| MCP governance | `docs/MCP_GOVERNANCE.md` |
| Capability registry | `docs/CAPABILITIES.md` |
| AIS-OS integration mapping | `docs/AIS_OS_INTEGRATION.md` |
