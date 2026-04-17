# Inventory — Generated Source of Truth

_Generated: 2026-04-17T00:19:41Z · commit: `d753627`_

Do not hand-edit. Regenerate with `make inventory` or `scripts/inventory.sh --md`.

## Counts

| Surface | Count | Notes |
|---------|-------|-------|
| Skills | 197 | SKILL.md files; 46,048 total lines |
| Commands | 83 | 37 custom + 31 SuperClaude + 15 BMAD |
| Agent definitions | 239 | 237 real + 2 metadata (REGISTRY, README) |
| — core (L0–L6) | 66 | top-level .md files |
| — Wave 1 stage | 126 | department subdirs |
| — Wave 2 surface | 45 | `agents/surfaces/` |
| Path rules | 6 | `rules/*.md` |
| Reference docs | 26 | `docs/*.md` |
| Hook scripts | 11 | `hooks/*.sh` |
| Hook entries (total) | 19 | in `settings.json`; 7 are inline commands |
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
  "generated_at": "2026-04-17T00:19:41Z",
  "commit": "d753627",
  "skills": {
    "count": 197,
    "skill_md_total_lines": 46048
  },
  "commands": {
    "total": 83,
    "custom": 37,
    "superclaude": 31,
    "bmad": 15
  },
  "agents": {
    "files_total": 239,
    "agents_real": 237,
    "core_l0_l6": 66,
    "wave1_stage": 126,
    "wave2_surface": 45
  },
  "rules": 6,
  "docs": 26,
  "hooks": {
    "shell_scripts": 11,
    "settings_entries": 19,
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
