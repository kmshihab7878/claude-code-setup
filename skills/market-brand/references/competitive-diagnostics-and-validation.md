# Competitive Diagnostics and Validation

Competitor voice comparison (Step 6), consistency audit (Step 7), validation
checklists, and anti-patterns.

## Competitor Voice Comparison

Compare the brand's voice to 2-3 key competitors using the same dimensions
and archetype framework.

### Voice Comparison Matrix

| Dimension | [Brand] | Competitor 1 | Competitor 2 | Competitor 3 |
|-----------|---------|--------------|--------------|--------------|
| Formal ↔ Casual | X/10 | X/10 | X/10 | X/10 |
| Serious ↔ Playful | X/10 | X/10 | X/10 | X/10 |
| Technical ↔ Simple | X/10 | X/10 | X/10 | X/10 |
| Reserved ↔ Bold | X/10 | X/10 | X/10 | X/10 |
| Primary Archetype | [type] | [type] | [type] | [type] |

If the user previously ran `/market competitors`, reuse that data — do not
re-derive competitor scores from scratch.

### Differentiation Assessment

For each competitor pair:

- **How distinct** is the brand's voice from the competitor's?
- **Where do voices overlap** — flag as differentiation opportunity.
- **What voice territory is unoccupied** in the competitive landscape?
- **Specific recommendations** for vocal differentiation — phrasing-level,
  not abstract.

A brand cannot meaningfully differentiate on every dimension simultaneously.
Pick the 1-2 dimensions where the gap is largest **and** the brand can
authentically own the contrast.

## Consistency Audit

| Channel | Voice consistency | Notes |
|---------|-------------------|-------|
| Homepage | Consistent / Mostly / Inconsistent | [specific observations] |
| About page | Consistent / Mostly / Inconsistent | [notes] |
| Blog | Consistent / Mostly / Inconsistent | [notes] |
| Social media | Consistent / Mostly / Inconsistent | [notes] |
| Email | Consistent / Mostly / Inconsistent | [notes] |
| Product pages | Consistent / Mostly / Inconsistent | [notes] |

**Overall Consistency Score: X/10.**

### Common consistency issues

- Different writers creating noticeably different tones.
- Social media voice drastically different from website.
- Formal website copy but casual email newsletters.
- Blog content written in a completely different voice than product pages.
- Error messages or microcopy that feels off-brand.
- Old pages that haven't been updated to match current brand voice.

Frame consistency issues as **opportunities**, not failures. Drift is common
and fixable; positioning it as a failure makes the recommendation harder to
adopt.

## Validation Checklists

### Voice analysis quality

- [ ] Every dimension score is backed by 3-5 quoted examples from real sources.
- [ ] Score range is 1-10 (no binary scores, no half-points).
- [ ] Source coverage includes at least 3 of: homepage, about, product, blog, social, email, support.
- [ ] If source is single-page-only, the limitation is stated explicitly in the output.
- [ ] Voice (consistent personality) and tone (context-shifted) are kept distinct.

### Archetype quality

- [ ] Primary and (optional) secondary archetype named.
- [ ] Archetype fit rated Strong / Moderate / Weak with evidence.
- [ ] Evidence explains why this archetype, not why-not the others.

### Vocabulary quality

- [ ] 15-20 characteristic words identified across the four categories.
- [ ] Words-to-avoid section is non-empty.
- [ ] Signature phrases section flags any missing tagline rather than fabricating one.

### Competitor comparison quality

- [ ] 2-3 competitors actually observed; competitor scores not invented.
- [ ] Each competitor URL was fetched, or data was reused from a prior `/market competitors` run.
- [ ] Differentiation recommendations are phrasing-level, not abstract.

### Consistency audit quality

- [ ] All 6 default channels scored (Consistent / Mostly / Inconsistent).
- [ ] Each rating includes specific observations.
- [ ] Issues are framed as opportunities, not failures.

### Output deliverable quality

- [ ] `BRAND-VOICE.md` file is written to the current directory.
- [ ] All required sections in the template are present.
- [ ] Missing tagline / boilerplate / brand story flagged, not fabricated.
- [ ] Copy samples (5-8) are concrete and on-brand, not placeholders.

## Anti-Patterns

| Anti-pattern | Problem | Fix |
|--------------|---------|-----|
| Invented quotes | Fabricating evidence to support a score | Quote only what was actually observed; if insufficient, lower confidence or state limitation |
| Single-page extrapolation | Scoring a brand from homepage alone | Require ≥ 3 source types or state limitation explicitly |
| Voice/tone conflation | Treating tone shift as voice inconsistency | Separate the two; tone can vary, voice should not |
| Fabricated tagline | Inventing brand assets the user didn't provide | Mark missing layers; recommend creation |
| Binary archetype | Forcing a brand into one archetype when the data is mixed | Use Primary + Secondary; rate fit Strong/Moderate/Weak |
| Abstract recommendation | "Make the CTA more action-oriented" | Quote the current copy; propose a specific replacement |
| Consistency-as-failure | Framing audit findings as the brand's fault | Frame as an opportunity to strengthen the brand |
| Competitor score guessing | Filling in competitor scores without observation | Either observe directly or reuse `/market competitors` output; otherwise mark NA |
