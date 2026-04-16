# Elite Operations Methodology
## For `kmshihab7878/claude-code-setup`

A behavioral execution layer that integrates with your existing `~/.claude/` ecosystem. Turns the Claude Code Operations System doctrine into files that slot directly into your 196-skill, 239-agent, governed-pipeline setup.

---

## What's Inside

```
methodology/
├── README.md                          ← You are here
├── CLAUDE-MD-APPENDIX.md              ← Paste into your existing CLAUDE.md
├── skills/
│   └── elite-ops/
│       └── SKILL.md                   ← Core execution protocol skill
├── commands/
│   ├── ship.md                        ← /ship — full implementation mode
│   ├── audit-deep.md                  ← /audit-deep — full-stack audit
│   ├── fix-root.md                    ← /fix-root — root cause diagnosis
│   ├── polish-ux.md                   ← /polish-ux — UX-only refinement
│   └── council-review.md             ← /council-review — review board + execute
├── rules/
│   └── implementation.md              ← Universal implementation rules
└── docs/
    └── ELITE-OPS-METHODOLOGY.md       ← Full integration map & reference
```

---

## Install (3 steps)

### 1. Copy files into `~/.claude/`

```bash
# From this directory:
cp -r skills/elite-ops    ~/.claude/skills/elite-ops
cp commands/*.md           ~/.claude/commands/
cp rules/implementation.md ~/.claude/rules/implementation.md
cp docs/ELITE-OPS-METHODOLOGY.md ~/.claude/docs/ELITE-OPS-METHODOLOGY.md
```

### 2. Add the appendix to your CLAUDE.md

Open `CLAUDE-MD-APPENDIX.md`, copy the markdown block inside, and paste it into your existing `~/.claude/CLAUDE.md` after the identity section.

### 3. Verify

```bash
claude
# Then type:
/ship test the elite ops integration
```

---

## How It Layers Over Your Setup

| Your Component | What This Adds |
|---|---|
| **CLAUDE.md** | Execution posture + ambiguity protocol + completion criteria |
| **10-stage pipeline** | Behavioral rules at GOAL, PLAN, EXECUTE, VALIDATE, DELIVER stages |
| **L0-L6 agents** | Sharper execution contracts (agents are reused, not replaced) |
| **196 skills** | 1 new skill (`elite-ops`) that wraps existing skills with execution standards |
| **78 commands** | 5 new mode commands that activate the execution protocol |
| **10 hooks** | No new hooks — relies on your existing `stop-verification.sh`, ruff, tsc |
| **Risk tiers T0-T3** | Maps to proportional validation scaling |
| **KB system** | Architecture decisions flow back to `kb/wiki/` |

Nothing is replaced. Everything is additive.

---

## Command Quick Reference

| Command | When to Use |
|---|---|
| `/ship [task]` | You want a complete, production-ready implementation |
| `/audit-deep [area]` | You want a thorough inspection before making changes |
| `/fix-root [bug]` | Something is broken and you need the real cause fixed |
| `/polish-ux [area]` | The logic works but the UX needs refinement |
| `/council-review [decision]` | High-stakes change that benefits from multiple perspectives |

---

## Relationship to Existing Commands

| If you already use... | The new equivalent... | Difference |
|---|---|---|
| `/plan` | `/ship` | `/ship` goes through planning AND executes. `/plan` stops at the plan. |
| `/ultraplan` | `/council-review` | `/council-review` adds multi-perspective debate before the plan+execute loop. |
| `impeccable-polish` | `/polish-ux` | `/polish-ux` includes accessibility and copy review, not just visual polish. |
| `/security-audit` | `/audit-deep` | `/audit-deep` covers security + architecture + UX + code quality + test gaps. |
| Standard debugging | `/fix-root` | `/fix-root` mandates root cause analysis and regression tests. |

Use whichever feels right. The new commands are opinionated entry points, not replacements.
