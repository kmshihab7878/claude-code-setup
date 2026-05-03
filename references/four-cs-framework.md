# Four Cs of the AI OS

> Adapted from AIS-OS by Nate Herk (https://github.com/nateherkai/AIS-OS).
> The Four Cs are how the **system** is structured. The Three Ms (`references/3ms-framework.md`) are how the **operator** thinks.

---

## 1. Context

The OS knows who you are, what you do, what you care about, and how you want to work.

**Files:**
- `context/About Me.md` — operator profile, working style, knowledge depth
- `context/About Business.md` — ventures, customers, revenue model, constraints, north-star metric
- `context/Priorities.md` — this week / month / quarter
- `context/Voice Sample.md` — writing samples for tone-matching
- `context/Operating Preferences.md` — communication, engineering, approval defaults
- `decisions/log.md` — append-only operating decisions
- `kb/decisions/` — formal numbered ADRs
- `memory/` (this repo) and `~/.claude/projects/<project>/memory/` (per-project)

**Owned by:** the operator. Updated by `/onboard`, `/level-up`, and direct edits.

**Health check:** when `/audit` runs, the Context score is high if every active project has its own `MEMORY.md`, the user files are non-placeholder, and `decisions/log.md` has new entries from the past 30 days.

**Privacy guard:** Context files live in the repo. Never store secrets, customer PII, account credentials, or anything you wouldn't paste in a public PR. The `/onboard` skill has a hard guard against auto-filling identity from session env.

---

## 2. Connections

The OS can safely reach the tools and data sources you choose to connect.

**Files:**
- `connections.md` — registry of every tool, account, sensitivity, status, access method
- `docs/CONNECTIONS_ROADMAP.md` — the seven-domain roadmap (Revenue, Customer, Calendar, Comms, Tasks, Meetings, Knowledge)
- `.env.example` — placeholder for credentials (real `.env` is gitignored)
- `CLAUDE.md § Active MCP Servers` — what's actually live right now
- `references/api-integration-principles.md` — when to prefer direct API over MCP
- `references/direct-api-vs-mcp.md` — decision matrix

**Access methods (in order of preference for deterministic work):**
1. Manual export (zero risk, slowest)
2. Direct API with read-only credentials in `.env`
3. MCP server with whitelisted tool functions (`hooks/mcp-security-gate.sh`)
4. CLI with limited scope
5. Webhooks for inbound only
6. Workflow tools (Zapier/Make/n8n) for orchestration
7. **Never connect** when the tool is irreversible and you have no off-button

**Health check:** Connections score is high when every tool listed in `connections.md` has a documented access method, sensitivity tier, and a "what happens if compromised" line.

**Rules:**
- No real secrets in the repo. Ever. `.env` and `*.key`/`*.pem` are gitignored.
- Use a dedicated **AI OS service account** for sensitive systems (money, customers, business data) — not your personal account.
- Document every connection before using it.
- Prefer direct API for deterministic automations.
- Use MCP when tool abstraction is genuinely safer or faster.

---

## 3. Capabilities

The OS has reusable skills, scripts, and recipes that perform work.

**Surfaces:**
- `skills/` — 200+ skill definitions (judgment-heavy work)
- `commands/` — 80+ slash commands (entry points and workflows)
- `agents/` — 240 agent definitions (delegated work with a defined posture)
- `recipes/` — parameterized YAML workflows (composable pipelines)
- `scripts/` — deterministic shell scripts (boring, reliable)
- `hooks/` — pre/post-tool guards (safety rails)
- `references/skill-building-framework.md` — the 6-step pattern for adding new capabilities

**Health check:** Capabilities score is high when:
- Every workflow you've done 3+ times this week has a corresponding skill or script
- No skill is over 500 lines (heavy content lives in `references/`)
- Every skill has an improvement loop documented
- The capability registry (`docs/CAPABILITIES.md`) is up to date

**Build order (cheapest → most expensive):**
1. **Script** — for deterministic, repeatable operations (formatting, file moves, API calls with no judgment)
2. **Skill** — for judgment-heavy workflows that benefit from LLM reasoning
3. **Agent** — for multi-step workflows that need persona/posture (e.g. "act as the security reviewer")
4. **Recipe** — for composing the above into pipelines
5. **MCP integration** — for new tool surfaces

Boring beats fancy. A 30-line bash script that runs reliably is worth more than a 4-agent orchestration that needs babysitting.

---

## 4. Cadence

The OS runs on daily, weekly, and scheduled loops — but only after workflows are proven manually.

**Loops:**
- **Daily:** `/daily-plan` (morning) → work → `/end-of-day-review` (evening)
- **Weekly (Friday):** `/audit` → `/level-up` → ship one artifact → update `decisions/log.md`
- **Quarterly:** prune `archives/`, refresh `context/Priorities.md`, retire stale skills

**Files:**
- `docs/CADENCE.md` — the full cadence model
- `skills/daily-plan/SKILL.md`
- `skills/end-of-day-review/SKILL.md`
- `skills/weekly-operating-review/SKILL.md`
- `skills/audit/SKILL.md`
- `skills/level-up/SKILL.md`

**Cadence options (in order of safety):**
1. **Manual Claude Code session** — you trigger every run, full control, zero infrastructure
2. **Local scheduled tasks** (`launchd`, `cron`) — your machine must be on
3. **Cloud routines** (`/schedule` command) — only after the workflow is proven and secrets are managed via env vars

**Health check:** Cadence score is high when:
- The last `/audit` was within 14 days
- Every recurring loop has a documented kill switch
- No `/schedule`-d job has been silently running for 30+ days without review

**Anti-pattern:** automating a broken workflow. Cadence comes **last**. If `/level-up` proposes scheduling something you've never run manually, refuse.

---

## Dependency rule

```
Context  →  is non-skippable, must be populated first
   ↓
Connections + Capabilities  →  can build in parallel after Context
   ↓
Cadence  →  comes last, only after workflows are proven manually
```

Building Cadence on weak Context is how people end up with daily AI emails they ignore.

---

## How `/audit` scores the Four Cs

Each pillar gets a score 0-25 (total 100):

| C | Score 0-5 | Score 10-15 | Score 20-25 |
|---|-----------|-------------|-------------|
| **Context** | Placeholder files only | Some pillars filled, stale | All pillars current, decisions log live |
| **Connections** | Nothing documented | Some tools listed | Every tool has access method + sensitivity tier |
| **Capabilities** | Default skills only | Some custom skills, no improvement loops | Capability registry current, regular skill evolution |
| **Cadence** | No loops running | Some manual loops | Daily/weekly cadence stable for 30+ days |

The first `/audit` run typically scores 15-30/100. That is the baseline, not a verdict. The point is to track the trend.
