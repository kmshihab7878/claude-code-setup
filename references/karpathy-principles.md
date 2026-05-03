# Karpathy Principles — Behavioral Governor for AI Coding

> Distilled from forrestchang/andrej-karpathy-skills, which catalogues the most common ways LLMs fail at coding: hidden assumptions, overcomplication, unnecessary edits, weak verification.

> This is a **behavioral layer**, not a tool. It does not own surfaces. It modifies HOW every other surface (skills, agents, commands) operates when shipping code.

---

## Why this layer exists

This repo's AI OS already has scope, governance, and capability. The risk is not "not enough capability." The risk is "too much machinery" — agents wandering into adjacent code, skills building frameworks for one-off needs, plans that ship without verification.

The Karpathy principles push the opposite force:

- Think first, code second
- Smallest solution that works
- Touch only what the task requires
- Verify before claiming done

These four lines fit on a sticky note. They do not require a new system. They sit above every coding workflow as a check.

---

## The four principles

### 1. Think Before Coding

**What:** State assumptions. Surface ambiguity. Push back when a simpler or safer path exists. Stop when confused.

**Why:** LLMs tend to silently pick one of several reasonable interpretations. The user only finds out by reading the diff, by which time the interpretation is now in the codebase.

**Failure modes this prevents:**
- Building the wrong thing fast
- "While I was here, I also fixed X" where X was a misunderstanding
- Missing the simpler solution because the LLM jumped to coding

**Practical rules:**
- If the request has multiple materially different interpretations, pick the safest minimal path AND state why — or ask one sharp question.
- If the system being changed wasn't inspected first, do that before editing.
- If a value or threshold is suggested by the user, confirm whether it was derived or guessed.

**When to relax:** trivial fixes (typos, formatting), quick exploratory scripts, throwaway prototypes.

---

### 2. Simplicity First

**What:** Implement the smallest solution that satisfies the goal. No speculative features, abstractions, config, or flexibility.

**Why:** LLMs are biased toward "professional-looking" code — patterns they've seen in popular libraries. That bias produces over-engineered solutions that are harder to read, harder to maintain, and slower to debug than the obvious version.

**Failure modes this prevents:**
- 200-line framework where a 20-line function would do
- Strategy patterns / factories / registries with one implementation
- Configurable parameters with one value
- Pre-optimising for scale the project doesn't have

**Practical rules:**
- Implement first. Add abstraction only when a SECOND caller actually exists.
- Configurability is debt. Add a flag only when two real callsites disagree.
- Three similar lines is fine; resist DRY-ing them prematurely.
- Boring deterministic code beats clever frameworks.

**When to relax:** when the operator explicitly asks for an extension point, or when a test explicitly proves a simpler version doesn't satisfy the spec.

---

### 3. Surgical Changes

**What:** Touch only files and lines needed for the task. No drive-by refactors. Every changed line must trace to the user's request.

**Why:** When the LLM "fixes" adjacent code, formatting, or APIs, the diff becomes harder to review, the chance of regression goes up, and the operator can't easily revert just one piece.

**Failure modes this prevents:**
- Behaviour change mixed with formatting change (reviewer can't separate them)
- Function signature change when the body change was enough
- "Cleanup" of pre-existing code that wasn't asked about
- Comments rewritten in passing
- Imports re-ordered
- Removing dead code that pre-dated the task

**Practical rules:**
- Every changed line should answer: "is this required by the task?"
- If you find code that should change but wasn't asked: open a separate explicit PR.
- Don't remove pre-existing dead code unless asked. (Removing dead code created BY this change is fine.)
- If the diff has unrelated edits, split it before requesting review.

**When to relax:** when the operator explicitly asks for a "cleanup pass" or "refactor sweep."

---

### 4. Goal-Driven Execution

**What:** Convert tasks into success criteria. Define verification before implementation. Loop until the goal is verified or explain why verification is blocked.

**Why:** LLMs default to "implementation then summarise." Without a stated success criterion and a verification step, the summary is hope, not evidence.

**Failure modes this prevents:**
- "Should work" in the summary instead of "ran X, got Y"
- Tests skipped because the diff "looks right"
- Verification deferred to the operator with no explanation
- Vague tasks that drift into vague results

**Practical rules:**
- Before coding: state the success criterion in one sentence.
- Before coding: state how it will be verified (test command, manual flow, inspection).
- After coding: run the verification. If blocked, say WHY explicitly.
- "Done" without verification evidence is "claimed done."

**When to relax:** never. Even trivial fixes have a one-line verification step ("ran linter, no warnings").

---

## How these principles compose with the AI OS

| AI OS layer | Karpathy principles add |
|-------------|--------------------------|
| **Three Ms** (operator mindset) | Compatible — Three Ms is how the operator thinks before invoking tools; Karpathy is how the AI codes once invoked. They cover non-overlapping moments. |
| **Four Cs** (system structure) | Karpathy principles are evaluated by `/audit` under the Capabilities pillar — every active capability should pass them. Capabilities that consistently fail Surgical or Simplicity get archived. |
| **`/audit` rubric** | A capability that produces non-surgical diffs scores worse on Capabilities. |
| **`/level-up` recommendations** | Should themselves be small. The recommendation "build a 4-agent orchestration to automate weekly reports" violates Simplicity First — better recommend a 30-line script. |
| **MCP governance** | Karpathy adds: even when a tool is available, prefer not to use it if the task can be done simpler without it. |
| **Constitution (CLAUDE.md)** | The 10 Core Rules already cover much of this (incremental changes, root cause first, no fabrication, evidence first). Karpathy condenses them into four sticky-note rules that fit the daily flow. |

---

## When to invoke the Karpathy review

| Trigger | Run review? |
|---------|-------------|
| Trivial fix (typo, whitespace, one-line docs) | No — overhead > value |
| Non-trivial code change | YES — before edits AND after edits |
| Refactor (any size) | YES — refactors are the highest risk for non-surgical drift |
| Bug fix | YES — symptom-patching is the most common Surgical Changes violation |
| New feature | YES — Simplicity First is most violated here |
| Test generation | Sometimes — flag over-mocking, flag tests testing the wrong thing |
| Audit (already a review) | No — recursive |
| Pure docs change | No — different concern |
| Level-up recommendation | Sometimes — flag over-ambitious artifacts |

The skill is `skills/karpathy-review/SKILL.md`. The CLAUDE.md addendum (see `CLAUDE.md § Karpathy Operating Constraints`) gives the short-form rules every coding session should default to.

---

## Anti-pattern: caution that kills velocity

Karpathy's own framing: **these principles should not slow trivial tasks.** A typo fix doesn't need a four-section review. A one-line config change doesn't need a verification flow.

The principles apply with full weight to non-trivial work and with feather weight to trivial work. The judgement call is the operator's; the skill's "out of scope, skip" output is a valid result.

If running this skill ever feels like it's slowing the work more than it's catching real problems, that's a signal to tune the quality-gate table in `skills/karpathy-review/SKILL.md`, not to abandon the principle.

---

## Attribution

The four principles are adapted from Andrej Karpathy's observations about common LLM coding failures, as catalogued in forrestchang/andrej-karpathy-skills. This document is the integration into this repo's behavioral layer — phrasing and examples are this repo's own.
