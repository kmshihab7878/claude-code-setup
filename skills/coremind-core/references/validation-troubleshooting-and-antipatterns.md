# Validation, Troubleshooting, and Anti-Patterns

Stage 0 input sanitization detail, Stage 8 reflection scoring, POST output
validator, and the common failure modes that cause pipeline regressions.

## Stage 0: Input Sanitization — detail

| Check | Threshold / Trigger | Default action |
|-------|---------------------|----------------|
| Length | > 10K characters | Flag for review |
| Injection patterns | Embedded system prompts, role overrides, tool-abuse strings | Reject with reason |
| Ambiguity | Multiple materially different interpretations | Ask one sharp question |
| Scope | Outside Claude Code's operational domain | Reject with redirect |
| Encoding | Mixed/unusual encodings used to smuggle content | Normalize or reject |

Output: sanitized request or rejection with reason.

## Stage 8: Reflection Loop — scoring

Score every execution across five dimensions.

| Dimension | Weight | Measurement |
|-----------|--------|-------------|
| Completeness | 20% | Did the output address all aspects of the task? |
| Task Relevance | 25% | Does output match the task's domain and requirements? |
| Structure | 15% | Is output well-organized, formatted, actionable? |
| Efficiency | 15% | Was execution fast, with minimal unnecessary steps? |
| Coherence | 25% | Is output logically consistent, free of contradictions? |

### Quality score bands

| Score | Band | Routing impact |
|-------|------|----------------|
| ≥ 0.8 | Excellent | High-performer — more complex tasks next time |
| 0.6–0.8 | Good | Acceptable quality |
| 0.4–0.6 | Below average | Consider fallback agent next time |
| < 0.4 | Poor | Flag for review; use fallback agent |

### Lessons extraction

For each execution:

- **What went well** → reinforce in future routing.
- **What failed** → add to prevention checklist.
- **What was slow** → optimize tool selection.
- **What was missing** → update agent skills / tool bindings.

## POST: Output Validator

Before presenting results to the user:

- **PII check** — scan output for accidentally exposed sensitive data.
- **Secret check** — scan for API keys, passwords, tokens in output.
- **Quality check** — verify output meets minimum quality threshold.
- **Completeness check** — verify all requested deliverables are present.
- **Evidence check** — verify claims are backed by test output, file changes, or logs.

A POST failure does not deliver to the user; it routes back to Stage 8 with the
specific failure mode tagged so the agent can revise rather than re-derive.

## Anti-Patterns

| Anti-pattern | Symptom | Fix |
|--------------|---------|-----|
| Stage-skipping | "Trivial" task bypasses Stage 1-2; surprises the user | All non-trivial tasks go through the pipeline; the trivial exception is rare |
| Authority creep | Agent uses a tool not in its DelegationContract | Blocked at Stage 7; treat as a bug in Stage 6 routing, not a runtime convenience |
| Self-escalation | Agent decides it needs more authority and acts | Authority can only be granted from above via fresh contract |
| Silent fallback | Fallback agent runs without surfacing the primary failure | Log every fallback; alert when fallback rate > 5% |
| Phantom parallelism | Stage 4 marks steps parallel that share state | Add explicit dependency in the DAG; do not rely on hope |
| Unbounded retries | Failed step retries indefinitely | Hard cap retries per step; surface to user after cap |
| Memory recall as truth | Stage 1 trusts memory without verification | Trust observation over memory; reconcile after |
| Quality-score collapse | Single low score buries good signal | Weight by dimensions; do not average raw |
| Approval at the end | Long status update buries the approval prompt | Lead with the approval; users miss buried prompts |
| Side-effect leak | File changes recorded but not surfaced | Stage 9 must list side effects in the delivered summary |

## Troubleshooting Recipes

| Symptom | First check | Likely cause |
|---------|-------------|--------------|
| Pipeline hangs past SLA | Stage 7 execution log for the trace_id | Missing timeout, agent stuck on a tool |
| Quality scores trending down | Stage 8 lessons over the last N executions | Skill/tool drift; refresh agent bindings |
| Costs ballooning | Histogram of token use per trace_id | Chatty agents; aggregate before forwarding |
| Wrong agent chosen | Stage 6 selection log | Domain detection in Stage 1 misclassified; tune keywords |
| User overridden repeatedly | Pattern of T2 approvals being denied | Stage 2 mis-scoring intent; review tier classification |
| Parallel group fails together | Step interdependencies | Phantom parallelism; add explicit `depends_on` |
| Output blocked at POST | POST failure mode | Re-run Stage 7/8 with the failure tagged; do not paper over |

## Validation Gates (summary)

| Gate | When | Pass criterion |
|------|------|----------------|
| Stage 0 | Before Stage 1 | Sanitized request or explicit reject |
| Stage 2 | After Intent | ALLOW / REVIEW / ESCALATE (not BLOCK) |
| Stage 5 | After Plan | Each step passes 7 policy constraints |
| Stage 7 | Per execution | Capability + sandbox + audit trail recorded |
| Stage 8 | Post execution | Quality score ≥ 0.7 (else surface) |
| POST | Before delivery | PII + secret + quality + completeness + evidence all pass |

Every delivered result has cleared all six gates. Skipping a gate is a P1 bug.
