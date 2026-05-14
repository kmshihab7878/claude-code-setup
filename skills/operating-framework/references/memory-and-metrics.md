# Memory-to-Mastery and benchmark metrics (Sections 9 & 10 detail)

The four memory domains (Architecture / Failure / Execution / Preference) with mapped memory files, the promotion policy (3+ confirmations rule), and the 8-row benchmark-metrics table with targets and measurement methods. SKILL.md keeps a compact summary; this file holds the full tables.

## 9. Memory-to-Mastery

The framework uses 4 memory domains to learn and improve over time.

| Domain | Maps To | What Gets Stored |
|--------|---------|------------------|
| **Architecture** | `memory/architecture.md` | System overviews, component maps, integration patterns |
| **Failure** | `memory/mistakes.md` | What went wrong, root cause, prevention strategy |
| **Execution** | `memory/patterns.md` | Code patterns, conventions, successful approaches |
| **Preference** | `memory/preferences.md` | Coding style, doc standards, naming conventions, verification preferences |

### Promotion Policy

When a pattern succeeds **3 or more times**:
- A successful code pattern -> promote to `patterns.md` as a template
- A successful prevention strategy -> promote to checklist in `mistakes.md`
- A successful workflow -> candidate for new skill or command
- A user preference -> solidify in `preferences.md`

When recording, note the success count: `(confirmed: N)`.

---

## 10. Benchmark Metrics

Track these to measure framework effectiveness.

| # | Metric | Target | How to Measure |
|---|--------|--------|----------------|
| 1 | First-pass success rate | > 85% | Tasks completed without rework |
| 2 | Gate compliance | 100% | No gate violations detected |
| 3 | Root cause accuracy | > 90% | Fix addresses actual root cause |
| 4 | Artifact completeness | 100% | All required artifacts produced |
| 5 | Risk tier accuracy | > 95% | Correct tier assigned initially |
| 6 | Evidence attached | 100% | Every completion has proof |
| 7 | Memory promotion rate | Monthly | Patterns promoted per month |
| 8 | Regression rate | < 5% | Bugs reintroduced after fix |

Monthly review: check metrics, update patterns, promote successful approaches.
