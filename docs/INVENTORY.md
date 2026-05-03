# Inventory — Generated Source of Truth

_Generated: 2026-05-03T05:18:58Z · commit: `a7cb3a4`_

Do not hand-edit. Regenerate with `make inventory` or `scripts/inventory.sh --md`.

## Counts

| Surface | Count | Notes |
|---------|-------|-------|
| Skills | 209 | SKILL.md files; 47,060 total lines |
| Commands | 88 | 42 custom + 31 SuperClaude + 15 BMAD |
| Agent definitions | 245 | 243 real + 2 metadata (REGISTRY, README) |
| — core (L0–L6) | 72 | top-level .md files |
| — Wave 1 stage | 126 | department subdirs |
| — Wave 2 surface | 45 | `agents/surfaces/` |
| Path rules | 6 | `rules/*.md` |
| Reference docs | 40 | `docs/*.md` |
| Hook scripts | 16 | `hooks/*.sh` |
| Hook entries (total) | 21 | in `settings.json`; 7 are inline commands |
| Recipes | 13 | 10 primary + 3 sub-recipes |
| KB wiki articles | 8 | `kb/wiki/*.md` — includes INDEX, methodology |
| KB raw files | 0 | `kb/raw/` |
| KB outputs | 0 | `kb/outputs/` |
| MCP — connected | 8 | from CLAUDE.md table |
| MCP — auth pending | 2 | from CLAUDE.md table |
| MCP — aspirational | 20 | from CLAUDE.md table (not installed) |

## JSON

```json
{
  "generated_at": "2026-05-03T05:18:58Z",
  "commit": "a7cb3a4",
  "skills": {
    "count": 209,
    "skill_md_total_lines": 47060
  },
  "commands": {
    "total": 88,
    "custom": 42,
    "superclaude": 31,
    "bmad": 15
  },
  "agents": {
    "files_total": 245,
    "agents_real": 243,
    "core_l0_l6": 72,
    "wave1_stage": 126,
    "wave2_surface": 45
  },
  "rules": 6,
  "docs": 40,
  "hooks": {
    "shell_scripts": 16,
    "settings_entries": 21,
    "inline_commands": 7
  },
  "recipes": {
    "total": 13,
    "primary": 10,
    "sub": 3
  },
  "kb": {
    "wiki_articles": 8,
    "raw_files": 0,
    "outputs_files": 0
  },
  "mcp": {
    "connected": 8,
    "auth_pending": 2,
    "aspirational": 20
  }
}
```
