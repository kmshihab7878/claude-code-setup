# Six-Step Skill-Building Framework

> When something becomes a skill: when a workflow is going to run 3+ times AND requires judgment that an LLM can do reliably with the right context. If it's deterministic, write a script. If it's one-shot, just do it manually.

> Adapted from AIS-OS by Nate Herk. Aligned to this repo's existing skill conventions in `skills/skill-architect/SKILL.md` and `skills/skill-evolution/SKILL.md`.

---

## The six steps

### 1. Name and trigger

```
Name: <verb-noun, kebab-case>
Trigger: <when does this skill activate? Slash command? Keyword in prompt? Domain match?>
Disable model invocation: <true if the skill should only fire from explicit /command, false if model can pick it>
```

A bad name leaks intent. A bad trigger creates collisions or silent skips.

Examples:
- `/onboard` — explicit slash command, `disable-model-invocation: true`
- `python-quality-gate` — model can invoke when Python files are touched
- `audit` — explicit `/audit` only

### 2. Goal

One sentence. What does the skill do, for whom, with what outcome?

> "Score the AI OS out of 100 across the Four Cs and surface the top 3 leverage gaps."

If the goal is multi-clause ("does X and Y and Z"), it's two skills.

### 3. Step-by-step process

Numbered, atomic, runnable.

```
1. Pre-flight checks (auth? context? state file?)
2. Inputs — what does the skill need?
3. Action — the actual work
4. Validation — how do you know it worked?
5. Output — what does the user see?
6. Logging — what is recorded for next time?
```

Each step is a verb + object. If a step requires judgment, write the **decision criteria** explicitly.

### 4. Reference files needed

Heavy content lives in `references/<topic>.md`, NOT in the skill itself.

```
references/
  3ms-framework.md          ← used by /audit, /level-up
  four-cs-framework.md      ← used by /audit, /onboard
  api-integration-principles.md  ← used by automation-designer agent
```

Why: the skill stays small (model loads it on every relevant query). References load only when needed. A 500-line skill costs more in context than a 50-line skill that points at a 1000-line reference.

**Rule of thumb:** if the skill exceeds 500 lines, split. If it exceeds 200 lines and most of it is examples or background, move the examples/background to `references/`.

### 5. Rules and guardrails

Explicitly list:
- **What the skill MUST do** (e.g. "must show diff before writing")
- **What the skill MUST NOT do** (e.g. "must not modify settings.json")
- **Failure modes and recoveries** (e.g. "if user pastes a credential → refuse, redact, ask again")
- **Idempotency** (re-running the same input must produce the same outcome)
- **Privacy** (what does this skill read/write that's sensitive?)

This is the section that prevents the skill from becoming a footgun in week 6.

### 6. Improvement loop

Every skill includes:

```markdown
## Improvement loop
After every run, ask:
1. What did the user have to correct? → fix the prompt or step
2. What surprised me about the input? → add a guard or a clarification step
3. What output did the user re-edit before using? → tighten the output spec
4. What broke? → add a failure mode + recovery to step 5
```

Skills that don't improve become outdated. The improvement loop is what prevents that.

---

## Where skills live

| Scope | Path | When to use |
|-------|------|-------------|
| Project-level | `skills/<name>/SKILL.md` | Skill is specific to this repo or to claude-code-setup itself |
| User-global | `~/.claude/skills/<name>/SKILL.md` | Skill is broadly reusable across all projects (rare — most skills should start project-level) |
| Plugin | `~/.claude/plugins/.../skills/<name>/SKILL.md` | You're publishing the skill |

**Default:** start project-level. Promote to global only after the skill has run successfully in 2+ different projects.

---

## When NOT to write a skill

- **One-shot work** — just do it
- **Deterministic operation** — write a `scripts/*.sh` or `recipes/*.yaml`
- **Workflow that genuinely needs an agent persona** — write an agent (`agents/<name>.md`)
- **Pure documentation** — write a reference (`references/<topic>.md`)
- **A guard / safety check** — write a hook (`hooks/<name>.sh`)
- **A complete pipeline of multiple skills** — write a recipe (`recipes/<name>.yaml`)

A skill is the right abstraction when **judgment + repetition + LLM strength** all apply.

---

## Boring deterministic scripts beat fancy agents 9/10 times

If the work is:
- Same inputs → same outputs
- No fuzzy matching
- No taste/judgment
- No multi-step decisions

…then it's a script. Don't dress it up as an agent. Don't wrap it in a skill that calls an LLM. Write the bash, validate it once, run it forever.

The 1/10 cases where agents win are work that genuinely benefits from natural language understanding, multi-step planning, or pattern recognition across loosely-structured inputs. That's where you reach for agents and skills.

---

## Skill template (copy this when building a new one)

```markdown
---
name: <verb-noun>
description: <1 sentence — when to use, what it produces, when NOT to use>
disable-model-invocation: <true|false>
---

# /<command-name>? — <Title>

## When to use
- ...
- ...

## When NOT to use
- ...

## Inputs
- ...

## Outputs
- ...

## Hard rules
- MUST: ...
- MUST NOT: ...

## Steps
1. ...
2. ...

## Failure modes
| Symptom | Cause | Fix |
|---------|-------|-----|

## Reference files
- references/<topic>.md
- ...

## Improvement loop
After every run, ask:
1. What did the user correct?
2. What surprised me?
3. What did the user re-edit?
4. What broke?
```
