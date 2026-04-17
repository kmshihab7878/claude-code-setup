# Architecture Decision Records (ADRs)

_Append-only log of significant decisions made while evolving this repo. Each ADR captures the reasoning at decision time so future-me (or a reviewer) can tell whether the original context still holds._

## Template

```markdown
# ADR-{NNN}: {title in imperative present tense}

**Date:** YYYY-MM-DD
**Status:** proposed | accepted | superseded by ADR-NNN | deprecated
**Deciders:** {names / roles}

## Context

What is the situation and why is a decision needed? One or two short paragraphs. Include the relevant state: commit SHA, telemetry signal, user constraint, etc.

## Decision

What we decided. State it as a declarative sentence in the present tense. If there are alternatives, state the chosen one explicitly.

## Alternatives considered

Enumerate at least two. For each: what the approach was and why it lost.

## Consequences

What this decision commits us to. Include both positive (what now becomes easier) and negative (what now becomes harder or gets locked in).

## Revisit trigger

Under what conditions should we reopen this decision? Be specific — "after 14 days of telemetry", "when we hit N users", "if postgres MCP ships", etc. Without a trigger, accepted ADRs accumulate forever.

## References

- Related files, commits, external docs.
```

## Filename convention

`ADR-{NNN}-{kebab-case-title}.md` — e.g. `ADR-001-virtual-domain-indexes.md`. Numbers are monotonic; never reuse.

## When to write one

- Any structural decision that affects more than one file or one subsystem.
- Any decision that deliberately chose one approach over an obvious alternative.
- Any decision that will look surprising to someone reading the code later.

Do NOT write an ADR for every commit. A trivial refactor or typo fix doesn't need one.

## Reading order for new contributors

Start from ADR-001 and read forward. Status `superseded` entries stay in the log; they are part of the decision history.

## Current ADRs

_Phase 1 of the restructure produced one implicit ADR (the virtual-index decision). It is documented in `docs/ARCHITECTURE.md` §1 rather than a separate ADR file — the rationale lives there because the whole doc exists to explain that call. Future significant decisions land here as ADR-001 onward._
