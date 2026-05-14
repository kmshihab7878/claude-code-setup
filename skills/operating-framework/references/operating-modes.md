# Operating modes (Section 4 detail)

The four operating modes (A Founder / B Elite Engineering / C Recovery / D Secure Delivery) with full when-to-use, command sequence, agents, and required artifacts per mode. SKILL.md keeps the mode-index table; this file holds the full per-mode detail.

## 4. Operating Modes

Modes determine **which tools and sequence** to use.

### Mode A: Founder (Idea to Product)

**When**: New product, feature from scratch, greenfield work.

**Sequence**: `/sc:brainstorm` > `/spec` > `/bmad:architecture` > `/plan` > Build > Verify

**Agents**: requirements-analyst, architect, business-panel-experts

**Artifacts**: Brief, spec, architecture doc, implementation plan

### Mode B: Elite Engineering (Code Excellence)

**When**: Approved spec exists, clear implementation task.

**Sequence**: `/plan` > `/sc:test` > `/sc:build` > `/review` > `/sc:document`

**Agents**: python-expert, tester, code-reviewer

**Artifacts**: Implementation plan, tests, code, review findings, docs

### Mode C: Recovery (Fix and Harden)

**When**: Bug report, test failure, incident, regression.

**Sequence**: `/debug` > `/review` > `/sc:test` > `/sc:reflect`

**Agents**: debugger, root-cause-analyst, incident-responder

**Artifacts**: Root cause analysis, fix, regression test, post-mortem

### Mode D: Secure Delivery (Ship Safely)

**When**: Security-sensitive work, deployment, infrastructure changes.

**Sequence**: `/security-audit` > `/review` > `/sc:build`

**Agents**: security-auditor, ci-cd-engineer, docker-specialist

**Artifacts**: Security audit, deployment checklist, rollback plan

