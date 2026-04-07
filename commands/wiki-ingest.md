---
description: "Ingest new raw files from ~/.claude/kb/raw/ into wiki/. Creates/updates KB articles, updates INDEX.md and log.md."
---

Read `~/.claude/kb/CLAUDE.md` for the KB operating rules. Then:

1. **Scan raw/**: List all files in `~/.claude/kb/raw/` that have NOT yet been ingested (check wiki/ for corresponding articles and log.md for past ingest entries).

2. **For each new raw file**: Create or update wiki/ articles:
   - One summary article per source (kebab-case filename)
   - Concept/explanation pages for key ideas
   - Entity pages for people, tools, organizations
   - Use YAML frontmatter (name, description, confidence, last-updated, linked-sources, linked-wiki, tags)

3. **Update INDEX.md**: Add new article entries under the appropriate section.

4. **Update log.md**: Append a timestamped entry listing what was ingested.

5. **Rules**:
   - Never modify raw/ files
   - Every wiki/ claim must trace to a source
   - Use [[wikilinks]] for cross-references
   - Detect contradictions with existing articles — flag explicitly if found
   - Kebab-case filenames only

If $ARGUMENTS is provided, ingest only that specific file from raw/.
