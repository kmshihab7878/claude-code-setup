# Interface Critique and Troubleshooting Reference

This reference contains critique protocol, common failure modes, and repair patterns for product interfaces.

## Critique Priority

Review in this order:

1. Task completion: can the human do the primary job?
2. Navigation context: where am I, where can I go, and what matters?
3. Accessibility: focus, contrast, labels, keyboard, motion.
4. Data meaning: does the screen clarify action or decision?
5. Visual hierarchy: can a user scan the screen?
6. Consistency: tokens, spacing, surfaces, states, and typography.
7. Signature: does the interface feel product-specific?
8. Polish: motion, edge cases, density, and microcopy.

## Common Failure Modes

| Symptom | Likely Cause | Repair |
|---|---|---|
| Looks like a generic dashboard | Domain exploration did not shape structure | Rebuild around domain concepts and signature |
| Feels pretty but hard to use | Visual direction outran task hierarchy | Put primary task and navigation context first |
| Screen feels flat | Too few text and surface levels | Add hierarchy through type, spacing, and depth scale |
| Screen feels noisy | Too many accents, borders, or effects | Reduce accents and commit to one depth strategy |
| Controls feel unfinished | Missing hover, focus, disabled, loading, or error states | Add full state coverage |
| Product feel is inconsistent | Intent not applied systemically | Align tokens, surfaces, type, and motion to one direction |
| Mobile breaks | Desktop-first spacing or fixed widths | Rework layout for responsive behavior |
| Data feels decorative | Metric lacks meaning or action | Tie data display to user decision |

## Repair Patterns

- Generic color: return to color world and choose domain-grounded materials.
- Generic layout: replace dashboard template structure with task-specific IA.
- Weak signature: make the signature appear in actual components, not just mood text.
- Harsh borders: lower opacity and build a border progression.
- Random spacing: define base unit and apply consistently.
- Weak typography: create distinct levels and purposeful numeric treatment.
- Inconsistent components: preserve surface treatment while varying internal layout by content.

## Critique Output Pattern

```text
Issue: [specific problem]
Impact: [user/task impact]
Evidence: [where it appears]
Fix: [concrete change]
Validation: [how to verify]
Severity: [Blocking/High/Medium/Low]
```

## Troubleshooting Flow

1. Re-read intent and domain exploration.
2. Inspect the implementation or screenshot.
3. Identify which default won.
4. Apply the smallest change that restores product-specific intent.
5. Re-run mandate checks.
6. Re-check `.interface-design/system.md` consistency when present.
