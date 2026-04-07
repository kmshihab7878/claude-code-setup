# Skill Review Checklist

Quality gate for accepting new or modified skills into `~/.claude/skills/`.

## Pre-Review

- [ ] Skill directory: `skills/<skill-name>/SKILL.md`
- [ ] Name follows [naming conventions](naming-conventions.md)
- [ ] No duplicate — checked existing [catalog](../README.md) for overlap

## Structure

- [ ] YAML frontmatter present with: `name`, `description`, `risk`, `tags`, `created`, `updated`
- [ ] Description is one line, includes action verbs and domain nouns (optimized for triggering)
- [ ] Risk level justified: `low` (read-only/local), `medium` (writes/external), `high` (destructive/financial)
- [ ] Tags exist in catalog taxonomy (or new tag justified)

## Content

- [ ] "How to use" section with invocation examples
- [ ] "When to use" section with 3+ trigger situations
- [ ] "When NOT to use" section with 2+ exclusions (prevents scope creep)
- [ ] Main content is actionable (rules, patterns, or process — not just theory)
- [ ] Code examples are minimal but complete
- [ ] Uses MUST/SHOULD/NEVER for rule clarity
- [ ] Cross-references to related skills and docs

## Quality

- [ ] No overlap >30% with existing skill (content was checked, not just name)
- [ ] Scope is single-purpose (one skill = one domain)
- [ ] Not a persona/agent disguised as a skill (agents are invokable personas, skills are rule sets)
- [ ] Tested: skill triggers correctly when its domain is mentioned in conversation
- [ ] Tested: skill does NOT trigger for unrelated topics

## Catalog Update

- [ ] Added to `skills/README.md` catalog table in correct category
- [ ] Added to tag index
- [ ] Updated `CLAUDE.md` skill count and list

## For Rewrites/Consolidation

- [ ] All unique content from absorbed skill preserved
- [ ] Absorbed skill's cross-references updated or redirected
- [ ] Absorbed skill directory deleted after verification
- [ ] Catalog updated with absorption note in "Deleted Skills" table
