# Elite Operations Methodology

## Integration Map for `kmshihab7878/claude-code-setup`

This methodology transforms the Claude Code Operations System doctrine into an execution layer that integrates with your existing `~/.claude/` ecosystem — 196 skills, 78 commands, 239 agents, 13 recipes, and the governed pipeline.

It does **not** replace your setup. It adds a behavioral operating layer on top of it.

---

## What This Adds vs. What You Already Have

| Capability | Your Current Setup | What This Adds |
|---|---|---|
| **Identity** | CLAUDE.md identity section | Owner-engineer execution posture |
| **Planning** | `/plan`, `/ultraplan` (10/15-stage pipeline) | Pre-build decision framework (3 decisions + locked assumptions) |
| **Repo awareness** | `repo-index` agent (L0) | Structured assimilation protocol with native-path detection |
| **Mode routing** | 78 slash commands | 5 mode packs (`/ship`, `/audit-deep`, `/fix-root`, `/polish-ux`, `/council-review`) |
| **Quality gates** | Hooks (ruff, tsc, context guard) | Multi-layer completion criteria checklist |
| **UI standards** | `impeccable-design`, `impeccable-audit`, `impeccable-polish` | Integrated product-quality rules for non-greenfield work |
| **Ambiguity handling** | Governed pipeline policy gates | Explicit decision tree: when to infer vs. when to ask |
| **Validation** | `stop-verification.sh` hook | Proportional validation protocol scaled to change size |
| **Communication** | CLAUDE.md tone rules | Senior-to-senior signal density standard |

---

## How to Install

### Step 1: Copy files into your `~/.claude/` structure

```bash
# From the methodology directory:
cp skills/elite-ops/SKILL.md     ~/.claude/skills/elite-ops/SKILL.md
cp commands/ship.md              ~/.claude/commands/ship.md
cp commands/audit-deep.md        ~/.claude/commands/audit-deep.md
cp commands/fix-root.md          ~/.claude/commands/fix-root.md
cp commands/polish-ux.md         ~/.claude/commands/polish-ux.md
cp commands/council-review.md    ~/.claude/commands/council-review.md
cp rules/implementation.md       ~/.claude/rules/implementation.md
cp docs/ELITE-OPS-METHODOLOGY.md ~/.claude/docs/ELITE-OPS-METHODOLOGY.md
```

### Step 2: Append identity layer to CLAUDE.md

Add this block to your existing `CLAUDE.md` under the identity section:

```markdown
## Execution Posture

You operate as an owner-level engineer, not a passive assistant.
Your default loop: understand → decide → execute → validate → ship.
You prefer finished systems over suggestive fragments.
You build what the user meant, not only what they typed — unless doing so would create risk or violate explicit constraints.
When the brief is rough but the safest high-quality path is inferable, proceed. State assumptions inline and continue.
```

### Step 3: Register the skill in your keyword detector (optional)

If your `hooks/keyword-detector.sh` supports auto-activation, add entries for the new commands so they trigger skill loading on relevant keywords.

---

## Architecture: How This Layers Over Your Pipeline

Your governed pipeline:
```
SANITIZE → PARSE → POLICY GATE → GOAL → PLAN → POLICY GATE → DELEGATE → EXECUTE → REFLECT → TRACK → WORLD STATE → VALIDATE → DELIVER
```

The elite ops methodology injects behavior at these stages:

| Pipeline Stage | Elite Ops Injection |
|---|---|
| **GOAL** | Build Intent declaration (what + why) |
| **PLAN** | 3 Key Decisions + Locked Assumptions + Repo Findings |
| **DELEGATE** | Agent selection from your L0-L6 hierarchy based on task domain |
| **EXECUTE** | Implementation Standard (no TODOs, no placeholders, backward-compatible) |
| **VALIDATE** | Proportional validation protocol |
| **DELIVER** | Ship Summary (what changed, why safe, remaining follow-ups) |

This means your existing pipeline governs **what runs and when**. The elite ops methodology governs **how the work is done inside each stage**.

---

## Agent Mapping

When the elite ops skill activates, it routes to your existing agents by task type:

| Task Domain | Your Agent | Authority Level |
|---|---|---|
| Architecture decisions | `system-architect` | L1 |
| Backend implementation | `backend-architect` | L2 |
| Frontend implementation | `frontend-architect` | L2 |
| Security review | `security-engineer` | L2 |
| Testing | `quality-engineer` | L2 |
| Performance | `performance-engineer` | L2 |
| Code review | `code-reviewer` | L6 |
| Debugging | `debugger` | L6 |

The methodology does not create new agents. It gives your existing agents a sharper execution contract.

---

## Skill Mapping

The methodology references your existing skills for specialized execution:

| When the task involves... | Use your existing skill... |
|---|---|
| Greenfield UI | `impeccable-design` |
| UI quality audit | `impeccable-audit` |
| UI micro-polish | `impeccable-polish` |
| Brand-aware design | `hue` |
| React components | `react-bits` |
| Security scanning | `/security-audit` recipe |
| Test generation | `/test-gen` command |
| Website cloning | `clone-website` |
| Multi-advisor decisions | `council` |

The elite ops skill acts as a **behavioral wrapper** — it sets the execution standard, then delegates to the right specialist skill.

---

## Command Reference

| Command | Purpose | Maps To |
|---|---|---|
| `/ship` | Full implementation mode. Inspect → plan → build → validate → deliver. | Replaces ad-hoc "build this" requests |
| `/audit-deep` | Architecture + code quality + UX debt + security + test gap analysis. | Extends `/security-audit` to full-stack |
| `/fix-root` | Root cause diagnosis. Narrow patch. Regression protection. | Extends standard debugging |
| `/polish-ux` | UX-only pass: microstates, copy, a11y, visual coherence. | Complements `impeccable-polish` |
| `/council-review` | Multi-perspective senior review → converge → execute. | Wraps `council` with execution |

---

## Risk Tier Integration

Your existing risk tiers map to the methodology's validation scaling:

| Your Risk Tier | Methodology Validation Level |
|---|---|
| T0 (Safe) | Targeted verification only |
| T1 (Local) | Relevant tests + smoke path |
| T2 (Shared) | Types, lint, targeted tests, integration path review |
| T3 (Critical) | Full validation suite + manual verification flow + edge case matrix |

---

## Completion Criteria

A task is **not complete** until:

1. Feature is implemented end-to-end at all necessary layers
2. Code fits the repository's existing architecture and conventions
3. Edge cases are handled reasonably
4. UX states are coherent (loading, empty, error, success)
5. Types/schemas/contracts are updated
6. Tests or validations are updated proportionally
7. The result is reviewable and realistically shippable
8. Ship Summary is delivered

This criteria applies regardless of which command invoked the work.

---

## Non-Negotiables

These rules override convenience in all modes:

- Never ship placeholders as real implementation
- Never create redundant abstractions without need
- Never refactor unrelated code for style alone
- Never ignore existing repo conventions
- Never skip edge cases on production-facing features
- Never ask permission when you can inspect and proceed
- Never claim completion without validation
- Never output "simplified version" unless the user explicitly asks

---

## Relationship to Knowledge Base

When the elite ops skill encounters domain decisions worth preserving:

1. Architecture decisions → log to `kb/wiki/` with YAML frontmatter if significant
2. Implementation patterns discovered → note in Ship Summary for future `/wiki-ingest`
3. Repo conventions detected → feed to `repo-index` agent context

This keeps your knowledge base growing as a side effect of productive work.
