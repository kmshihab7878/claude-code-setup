# Inventory — Generated Source of Truth

_Generated: 2026-04-17T03:11:20Z · commit: `013239c`_

Do not hand-edit. Regenerate with `make inventory` or `scripts/inventory.sh --md`.

## Counts

| Surface | Count | Notes |
|---------|-------|-------|
| Skills | 202 | SKILL.md files; 46,237 total lines |
| Commands | 84 | 38 custom + 31 SuperClaude + 15 BMAD |
| Agent definitions | 242 | 240 real + 2 metadata (REGISTRY, README) |
| — core (L0–L6) | 69 | top-level .md files |
| — Wave 1 stage | 126 | department subdirs |
| — Wave 2 surface | 45 | `agents/surfaces/` |
| Path rules | 6 | `rules/*.md` |
| Reference docs | 28 | `docs/*.md` |
| Hook scripts | 13 | `hooks/*.sh` |
| Hook entries (total) | 21 | in `settings.json`; 7 are inline commands |
| Recipes | 13 | 10 primary + 3 sub-recipes |
| KB wiki articles | 7 | `kb/wiki/*.md` — includes INDEX, methodology |
| KB raw files | 0 | `kb/raw/` |
| KB outputs | 0 | `kb/outputs/` |
| MCP — connected | 8 | from CLAUDE.md table |
| MCP — auth pending | 2 | from CLAUDE.md table |
| MCP — aspirational | 20 | from CLAUDE.md table (not installed) |

## JSON

```json
{
  "generated_at": "2026-04-17T03:11:20Z",
  "commit": "013239c",
  "skills": {
    "count": 202,
    "skill_md_total_lines": 46237
  },
  "commands": {
    "total": 84,
    "custom": 38,
    "superclaude": 31,
    "bmad": 15
  },
  "agents": {
    "files_total": 242,
    "agents_real": 240,
    "core_l0_l6": 69,
    "wave1_stage": 126,
    "wave2_surface": 45
  },
  "rules": 6,
  "docs": 28,
  "hooks": {
    "shell_scripts": 13,
    "settings_entries": 21,
    "inline_commands": 7
  },
  "recipes": {
    "total": 13,
    "primary": 10,
    "sub": 3
  },
  "kb": {
    "wiki_articles": 7,
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
