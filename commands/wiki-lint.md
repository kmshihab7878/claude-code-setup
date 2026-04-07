---
description: "Run a health check on ~/.claude/kb/wiki/. Flags contradictions, stale info (>90 days), broken links, gaps, and duplicate concepts."
---

Read `~/.claude/kb/CLAUDE.md` for the KB operating rules. Then run a full health check:

1. **Contradiction scan**: Read all wiki/ articles. Flag any pair of articles that make contradictory claims about the same topic. List: Article A + Article B + the contradiction.

2. **Staleness check**: Flag any article with `last-updated` older than 90 days from today. These need re-verification. List each with its age.

3. **Broken link check**: Scan for [[wikilinks]] in wiki/ articles that point to non-existent articles. List each broken link and where it appears.

4. **Gap analysis**: Based on the INDEX.md sections marked `(pending)` or empty categories, list what knowledge is missing. Cross-reference with log.md to see if any ingest attempts failed.

5. **Duplicate concept check**: Identify wiki/ articles that cover substantially the same topic and should be merged. List pairs with brief explanation.

6. **Orphan check**: Identify wiki/ articles that no other article links to. These may be useful but are disconnected from the knowledge graph.

7. **Fix what you can**:
   - Fix minor formatting issues
   - Update `last-updated` dates if you refresh content
   - Add missing [[wikilinks]] where obvious

8. **Flag what requires user input**: For contradictions or deletions, present them as choices:
   - "Article A says X. Article B says Y. Which is correct?"
   - "Article C appears to be a duplicate of Article D. Merge?"

9. **Update INDEX.md** and **log.md** with the lint run results.

Output format:
```
## KB Health Check — [DATE]

### Critical Issues (requires action)
...

### Warnings (review recommended)
...

### Stale Articles (>90 days)
...

### Gaps Identified
...

### Fixes Applied
...
```
