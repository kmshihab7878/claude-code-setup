---
description: "Research a question across ~/.claude/kb/wiki/ and save the answer to outputs/. Always files answers back to compound knowledge."
---

Read `~/.claude/kb/CLAUDE.md` for the KB operating rules. Then:

1. **Read INDEX.md first**: Load `~/.claude/kb/wiki/INDEX.md` to understand what articles are available.

2. **Load only relevant articles**: Based on the query, identify which wiki/ articles are relevant. Load only those — not the entire wiki.

3. **Synthesize with citations**: Answer the question using only what is in wiki/. Cite sources as [[article-name]] links. Mark anything uncertain as `[unverified]`.

4. **If gaps exist**: Identify what is NOT in the wiki that would be needed to fully answer. Flag these as knowledge gaps for future ingestion.

5. **Save to outputs/**: Write the complete answer to `~/.claude/kb/outputs/<topic>_<date>.md` with proper frontmatter.

6. **Update log.md**: Append a timestamped entry: `[DATE] QUERY: "[question]" → outputs/<filename>`

The query is: $ARGUMENTS

**Rules**:
- Never hallucinate outside what is in wiki/
- Always cite sources
- Always save the answer back to outputs/ (this is what makes the KB compound)
- If the answer requires information not in wiki/, say so explicitly and suggest which raw/ files to ingest
