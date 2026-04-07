# KhaledPowers Ultimate Operating Framework v1.0 — Reference Document

> Complete reference for the macro-level operating system governing Claude Code
> sessions. This document maps every framework concept to actual files, commands,
> agents, and MCP servers in Khaled's environment.

---

## 1. Philosophy

Seven principles govern all work:

1. **Route before acting** — Determine lane and risk before writing code.
2. **Specify before building** — Specs and plans precede implementation.
3. **Test before claiming progress** — Failing tests prove the feature, passing tests prove the fix.
4. **Review before merging** — Self-review minimum, council for T2+.
5. **Verify before completing** — Evidence attached to every completion.
6. **Record learnings before closing** — Update memory when patterns emerge.
7. **Escalate risk before irreversible actions** — Checkpoint at T2+.

**Default stance**: Do not jump into implementation. Do not treat confidence as
evidence. Do not mark work complete without artifacts. Do not take high-blast-radius
actions without an explicit checkpoint.

---

## 2. Session Contract

Every non-trivial task starts with a session header:

| Field | Definition | Options |
|-------|-----------|---------|
| TASK | One-line description | Free text |
| LANE | What kind of work | Explore, Specify, Build, Verify, Ship, Recover |
| RISK | How carefully to proceed | T0 Safe, T1 Local, T2 Shared, T3 Critical |
| MODE | Which tools and sequence | A Founder, B Elite Engineering, C Recovery, D Secure Delivery |
| ARTIFACTS | Required outputs | Per Artifact Matrix |
| EVIDENCE | What proves completion | Test output, logs, screenshots, build results |
| COUNCIL | Review depth | Solo, Lead+Reviewer, Full Council |
| DONE WHEN | Measurable completion | Specific condition |

**Command**: `/start-task` generates this header.

---

## 3. Lanes

| Lane | Command/Skill Entry Points | Produces |
|------|---------------------------|----------|
| Explore | `/sc:brainstorm`, `/sc:research`, `/bmad:research` | Questions, options, brief |
| Specify | `/spec`, `/bmad:prd`, `/bmad:tech-spec` | Spec, criteria, plan |
| Build | `/sc:build`, `/sc:implement`, `/plan` | Code, tests, docs |
| Verify | `/sc:test`, `/review`, `/sc:reflect` | Results, findings |
| Ship | `/pr-prep`, `/sc:git`, `/bmad:dev-story` | Commit, PR, deploy |
| Recover | `/debug`, `/sc:troubleshoot` | Root cause, fix, regression |

---

## 4. Risk Tier Details

### T0 Safe
- Scope: Read-only, formatting, comments, local exploration
- Requirements: None beyond standard behavior
- Examples: Reading files, adding type hints, running existing tests

### T1 Local
- Scope: Local code changes with test coverage
- Requirements: Follow lane + KhaledPowers gates
- Examples: New function, refactor with tests, bug fix in isolated module

### T2 Shared
- Scope: Changes affecting shared systems or state
- Requirements: Explicit checkpoint before action, Lead+Reviewer minimum
- Examples: Database migration, API contract change, shared config update

### T3 Critical
- Scope: Production, financial, security, or irreversible operations
- Requirements: Full council review, user approval, rollback plan documented
- Examples: Production deploy, trading operations, credential rotation, data deletion

---

## 5. Operating Modes — Full Reference

### Mode A: Founder

| Step | Command/Tool | Agent(s) | Output |
|------|-------------|----------|--------|
| 1. Discover | `/sc:brainstorm` | requirements-analyst | Requirements brief |
| 2. Specify | `/spec` | requirements-analyst | Spec + acceptance criteria |
| 3. Architect | `/bmad:architecture` | architect | Architecture document |
| 4. Plan | `/plan` | — | Implementation plan |
| 5. Build | `/sc:build` | python-expert | Code + tests |
| 6. Verify | `/sc:test`, `/review` | tester, code-reviewer | Test results, review |

### Mode B: Elite Engineering

| Step | Command/Tool | Agent(s) | Output |
|------|-------------|----------|--------|
| 1. Plan | `/plan` | — | Task breakdown |
| 2. Test | `/sc:test` | tester | Failing tests (TDD) |
| 3. Build | `/sc:build` | python-expert | Implementation |
| 4. Review | `/review` | code-reviewer | Review findings |
| 5. Document | `/sc:document` | documenter | Documentation |

### Mode C: Recovery

| Step | Command/Tool | Agent(s) | Output |
|------|-------------|----------|--------|
| 1. Investigate | `/debug` | debugger | Root cause analysis |
| 2. Review | `/review` | root-cause-analyst | Validation of root cause |
| 3. Test | `/sc:test` | tester | Regression test |
| 4. Fix | Direct edit | — | Minimal fix |
| 5. Reflect | `/sc:reflect` | incident-responder | Prevention strategy |

### Mode D: Secure Delivery

| Step | Command/Tool | Agent(s) | Output |
|------|-------------|----------|--------|
| 1. Audit | `/security-audit` | security-auditor | Security findings |
| 2. Review | `/review` | security-engineer | Threat assessment |
| 3. Build | `/sc:build` | ci-cd-engineer | Hardened implementation |
| 4. Deploy | Manual | docker-specialist, devops-architect | Deploy checklist + rollback |

---

## 6. Council Compositions

All agents referenced here exist in `~/.claude/agents/`.

### Product Council
- **requirements-analyst** — Validates problem definition and user needs
- **architect** — Evaluates technical feasibility and system fit
- **business-panel-experts** — Assesses market viability and strategic alignment

### Engineering Council
- **python-expert** — Code quality and implementation patterns
- **code-reviewer** — Standards compliance and maintainability
- **quality-engineer** — Test coverage and reliability

### Recovery Council
- **debugger** — Investigation methodology and evidence
- **root-cause-analyst** — Systemic analysis and prevention
- **incident-responder** — Impact assessment and communication

### Delivery Council
- **security-auditor** — Vulnerability assessment
- **ci-cd-engineer** — Pipeline and deployment safety
- **devops-architect** — Infrastructure reliability

---

## 7. Artifact Matrix — Full Reference

| Task Type | Brief | Spec | Plan | Tests | Code | Review | Audit | Checklist | Rollback | Root Cause |
|-----------|:-----:|:----:|:----:|:-----:|:----:|:------:|:-----:|:---------:|:--------:|:----------:|
| Idea | R | | | | | | | | | |
| Feature | | R | R | R | R | R | | | | |
| Bug fix | | | | R | R | | | | | R |
| Refactor | | | R | R | R | R | | | | |
| Security | | | | R | R | R | R | | | |
| Deploy | | | | | | | R | R | R | |
| Research | R | | | | | | | | | |

R = Required

---

## 8. Enforcement Rules

| # | Rule | Non-Negotiable | Enforcement |
|---|------|---------------|-------------|
| 1 | Boundary | #9 Approval first | Cannot cross lane without artifacts. Explore->Build requires Specify in between. |
| 2 | Evidence | #8 Evidence first | Completion packet requires proof. No "done" without test output or logs. |
| 3 | Root Cause | #7 Root cause first | Recover lane blocks fix until root cause stated with evidence. |
| 4 | Checkpoint | NEW | T2/T3 tasks pause for user confirmation before irreversible action. |
| 5 | Disposition | NEW | Every review/audit finding must be: accepted, deferred (with reason), or rejected (with reason). |

---

## 9. Memory Domains

| Domain | File | Contents | Promotion Trigger |
|--------|------|----------|-------------------|
| Architecture | `memory/architecture.md` | System overviews, component maps | New project or major redesign |
| Failure | `memory/mistakes.md` | Root causes, prevention strategies | 3+ successes -> checklist item |
| Execution | `memory/patterns.md` | Code patterns, conventions | 3+ successes -> template |
| Preference | `memory/preferences.md` | Style, naming, verification prefs | 3+ confirmations -> solidified |

**Promotion policy**: When a pattern, prevention strategy, or workflow succeeds
3 or more times, promote it:
- Code pattern -> template in patterns.md
- Prevention strategy -> checklist in mistakes.md
- Workflow -> candidate for new skill or command
- Preference -> solidified entry in preferences.md

---

## 10. Benchmark Metrics

| # | Metric | Target | Measurement |
|---|--------|--------|-------------|
| 1 | First-pass success rate | > 85% | Tasks completed without rework |
| 2 | Gate compliance | 100% | No KhaledPowers gate violations |
| 3 | Root cause accuracy | > 90% | Fix actually addresses root cause |
| 4 | Artifact completeness | 100% | All required artifacts produced |
| 5 | Risk tier accuracy | > 95% | Correct tier assigned on first assessment |
| 6 | Evidence attachment | 100% | Every completion has proof |
| 7 | Memory promotion rate | Monthly | Patterns promoted per month |
| 8 | Regression rate | < 5% | Previously fixed bugs reintroduced |

---

## 11. Completion Packet

Command: `/complete`

See the command definition for the full template. Key requirements:
- Cannot be generated if evidence is missing
- All review findings must be dispositioned
- All required artifacts must be accounted for
- Memory promotion candidates flagged when applicable

---

## 12. Integration Map

| Framework Concept | Implementation | File/Location |
|-------------------|---------------|---------------|
| Operating framework skill | Always-active skill | `~/.claude/skills/operating-framework/SKILL.md` |
| Session routing | Command | `~/.claude/commands/start-task.md` |
| Completion standards | Command | `~/.claude/commands/complete.md` |
| Micro-level gates | Meta-skill | `~/.claude/skills/using-khaledpowers/SKILL.md` |
| Pre-implementation check | Skill | `~/.claude/skills/confidence-check/` |
| Architecture memory | Memory file | `~/.claude/projects/*/memory/architecture.md` |
| Failure memory | Memory file | `~/.claude/projects/*/memory/mistakes.md` |
| Execution memory | Memory file | `~/.claude/projects/*/memory/patterns.md` |
| Preference memory | Memory file | `~/.claude/projects/*/memory/preferences.md` |
| Agent definitions | Agent files | `~/.claude/agents/*.md` |
| Reference doc | This document | `~/.claude/docs/OPERATING_FRAMEWORK.md` |

---

## 13. MCP Server Roles in the Framework

| Server | Framework Role |
|--------|---------------|
| **memory** | Persistent knowledge graph for cross-session learning |
| **github** | Ship lane operations (PRs, issues, reviews) |
| **filesystem** | Build/Verify lane file operations |
| **sequential** | Complex decision tree reasoning (council deliberations) |
| **context7** | Library docs for Build lane accuracy |
| **docker** | Delivery mode containerization |
| **penpot** | UI/UX design tasks (Mode A with frontend) |
| **aster** | T3 Critical financial operations |
