# Output templates (Phase 5 detail)

Full structure for the three required outputs: HTML report (file path, sections, design guidelines), Obsidian note (path, frontmatter, body), markdown transcript. SKILL.md keeps the output-list summary; this file holds the full schemas.

#### Output 1: HTML Report (saved to disk)

A self-contained HTML file (inline styles) saved to:
```
~/.claude/council-reports/council-<YYYY-MM-DD>-<slug>.html
```

Where `<slug>` is a 3-4 word kebab-case summary of the question (e.g., `should-we-migrate-to-k8s`).

Create the directory if it doesn't exist. Write the file using the Write tool.

Structure:
- **Header**: "Council Report" with the date, question, and domain badge
- **Intelligence Brief Box**: Summary of data gathered in Phase 0 (collapsed by default using `<details>`)
- **Question Box**: The decision being counciled, prominently displayed
- **Five Advisor Cards**: Each advisor's name, role tagline, and key points (use the real names, not letters)
- **Peer Review Section**: Summarized reviewer findings (aggregated themes, not all 15 individual answers)
- **Chairman Verdict Box**: Highlighted/accented box with the recommendation + confidence score badge
- **Next Step Box**: Button-style prominent box with the one concrete Monday-morning action
- **Prior Decisions**: If any past council decisions were referenced, link/note them

Design guidelines:
- Clean, professional, dark header with light body
- Color-coded advisor cards (each advisor gets a distinct accent color)
- Chairman verdict box gets a strong accent (green for HIGH confidence, amber for MEDIUM, red for LOW)
- Next step box gets an action color (orange or amber)
- Confidence badge: colored pill showing HIGH/MEDIUM/LOW
- Domain badge in header showing the classified domain
- Responsive layout, readable on mobile
- Use system fonts (no external font dependencies)

Also display the HTML in a code block so the user can see it inline.

#### Output 2: Obsidian Note (if vault is accessible)

Save a markdown note to the Obsidian vault:
```
Council Reports/council-<YYYY-MM-DD>-<slug>.md
```

Use `mcp__obsidian__write_note` with frontmatter:
```yaml
tags: [council, <domain>]
date: <YYYY-MM-DD>
domain: <classified domain>
confidence: <HIGH|MEDIUM|LOW>
recommendation: <one-line recommendation>
```

Body: Chairman synthesis + recommendation + next step + advisor summary (condensed, not full transcript).

If the Obsidian MCP fails (server not running, vault not accessible), skip silently — do not error.

#### Output 3: Markdown Transcript

Full raw transcript with:
- Intelligence Brief
- All five advisor responses (real names)
- All five reviewer responses
- Chairman reasoning, verdict, and confidence score
- At the very end, a small note: "**Mapping for transparency:** A=[Name], B=[Name], C=[Name], D=[Name], E=[Name]"

