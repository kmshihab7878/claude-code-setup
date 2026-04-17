#!/usr/bin/env bash
# Canonical inventory source of truth.
# Computes counts from filesystem. Emits JSON to stdout.
# Usage: scripts/inventory.sh [--md]
#   --md  also write docs/INVENTORY.md

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# ---- raw counts ----
skills=$(find skills -name SKILL.md -type f 2>/dev/null | wc -l | tr -d ' ')
skills_lines=$(find skills -name SKILL.md -type f -exec wc -l {} + 2>/dev/null | awk '/total/{print $1}' | tail -1)
skills_lines=${skills_lines:-0}

cmd_total=$(find commands -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
cmd_custom=$(find commands -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
cmd_sc=$(find commands/sc -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
cmd_bmad=$(find commands/bmad -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

agents_files=$(find agents -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
agents_real=$(find agents -name "*.md" -type f ! -name README.md ! -name REGISTRY.md 2>/dev/null | wc -l | tr -d ' ')
agents_core=$(find agents -maxdepth 1 -name "*.md" -type f ! -name README.md ! -name REGISTRY.md 2>/dev/null | wc -l | tr -d ' ')
agents_wave1=$(find agents -mindepth 2 -name "*.md" -type f -not -path "agents/surfaces/*" 2>/dev/null | wc -l | tr -d ' ')
agents_wave2=$(find agents/surfaces -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

rules=$(find rules -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
docs=$(find docs -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

hooks_shell=$(find hooks -name "*.sh" -type f 2>/dev/null | wc -l | tr -d ' ')

recipes_total=$(find recipes -name "*.yaml" -type f 2>/dev/null | wc -l | tr -d ' ')
recipes_sub=$(find recipes/sub -name "*.yaml" -type f 2>/dev/null | wc -l | tr -d ' ')
recipes_primary=$((recipes_total - recipes_sub))

kb_wiki=$(find kb/wiki -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
kb_raw=$(find kb/raw -type f ! -name ".gitkeep" 2>/dev/null | wc -l | tr -d ' ')
kb_outputs=$(find kb/outputs -type f ! -name ".gitkeep" 2>/dev/null | wc -l | tr -d ' ')

# hooks from settings.json (entries + inline)
hooks_entries=$(python3 - <<'PY' 2>/dev/null || echo 0
import json
try:
    s=json.load(open('settings.json'))
    n=0
    for _, arr in s.get('hooks',{}).items():
        for entry in arr:
            for _ in entry.get('hooks',[]):
                n+=1
    print(n)
except Exception:
    print(0)
PY
)
hooks_inline=$(python3 - <<'PY' 2>/dev/null || echo 0
import json
try:
    s=json.load(open('settings.json'))
    n=0
    for _, arr in s.get('hooks',{}).items():
        for entry in arr:
            for h in entry.get('hooks',[]):
                cmd=(h.get('command') or '').strip()
                if cmd and not cmd.startswith('~/') and not cmd.startswith('/'):
                    n+=1
    print(n)
except Exception:
    print(0)
PY
)

# MCP tiers (parsed from CLAUDE.md MCP section).
# Authoritative table row format:  "| ✓ | name | ..." / "| ⚠️ | ..." / "| ○ | ..."
mcp_connected=$(grep -cE '^\| ✓ \|' CLAUDE.md 2>/dev/null || echo 0)
mcp_auth_pending=$(grep -cE '^\| ⚠️ \|' CLAUDE.md 2>/dev/null || echo 0)
mcp_aspirational=$(grep -cE '^\| ○ \|' CLAUDE.md 2>/dev/null || echo 0)

generated_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
commit=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")

cat <<JSON
{
  "generated_at": "${generated_at}",
  "commit": "${commit}",
  "skills": {
    "count": ${skills},
    "skill_md_total_lines": ${skills_lines}
  },
  "commands": {
    "total": ${cmd_total},
    "custom": ${cmd_custom},
    "superclaude": ${cmd_sc},
    "bmad": ${cmd_bmad}
  },
  "agents": {
    "files_total": ${agents_files},
    "agents_real": ${agents_real},
    "core_l0_l6": ${agents_core},
    "wave1_stage": ${agents_wave1},
    "wave2_surface": ${agents_wave2}
  },
  "rules": ${rules},
  "docs": ${docs},
  "hooks": {
    "shell_scripts": ${hooks_shell},
    "settings_entries": ${hooks_entries},
    "inline_commands": ${hooks_inline}
  },
  "recipes": {
    "total": ${recipes_total},
    "primary": ${recipes_primary},
    "sub": ${recipes_sub}
  },
  "kb": {
    "wiki_articles": ${kb_wiki},
    "raw_files": ${kb_raw},
    "outputs_files": ${kb_outputs}
  },
  "mcp": {
    "connected": ${mcp_connected},
    "auth_pending": ${mcp_auth_pending},
    "aspirational": ${mcp_aspirational}
  }
}
JSON

if [ "${1:-}" = "--md" ]; then
  tmp=$(mktemp)
  "$0" > "$tmp"
  python3 - <<PY > docs/INVENTORY.md
import json
d=json.load(open("$tmp"))
print("# Inventory — Generated Source of Truth")
print()
print(f"_Generated: {d['generated_at']} · commit: \`{d['commit']}\`_")
print()
print("Do not hand-edit. Regenerate with \`make inventory\` or \`scripts/inventory.sh --md\`.")
print()
print("## Counts")
print()
print("| Surface | Count | Notes |")
print("|---------|-------|-------|")
print(f"| Skills | {d['skills']['count']} | SKILL.md files; {d['skills']['skill_md_total_lines']:,} total lines |")
print(f"| Commands | {d['commands']['total']} | {d['commands']['custom']} custom + {d['commands']['superclaude']} SuperClaude + {d['commands']['bmad']} BMAD |")
print(f"| Agent definitions | {d['agents']['files_total']} | {d['agents']['agents_real']} real + {d['agents']['files_total']-d['agents']['agents_real']} metadata (REGISTRY, README) |")
print(f"| — core (L0–L6) | {d['agents']['core_l0_l6']} | top-level .md files |")
print(f"| — Wave 1 stage | {d['agents']['wave1_stage']} | department subdirs |")
print(f"| — Wave 2 surface | {d['agents']['wave2_surface']} | \`agents/surfaces/\` |")
print(f"| Path rules | {d['rules']} | \`rules/*.md\` |")
print(f"| Reference docs | {d['docs']} | \`docs/*.md\` |")
print(f"| Hook scripts | {d['hooks']['shell_scripts']} | \`hooks/*.sh\` |")
print(f"| Hook entries (total) | {d['hooks']['settings_entries']} | in \`settings.json\`; {d['hooks']['inline_commands']} are inline commands |")
print(f"| Recipes | {d['recipes']['total']} | {d['recipes']['primary']} primary + {d['recipes']['sub']} sub-recipes |")
print(f"| KB wiki articles | {d['kb']['wiki_articles']} | \`kb/wiki/*.md\` — includes INDEX, methodology |")
print(f"| KB raw files | {d['kb']['raw_files']} | \`kb/raw/\` |")
print(f"| KB outputs | {d['kb']['outputs_files']} | \`kb/outputs/\` |")
print(f"| MCP — connected | {d['mcp']['connected']} | from CLAUDE.md table |")
print(f"| MCP — auth pending | {d['mcp']['auth_pending']} | from CLAUDE.md table |")
print(f"| MCP — aspirational | {d['mcp']['aspirational']} | from CLAUDE.md table (not installed) |")
print()
print("## JSON")
print()
fence = "\x60" * 3 + "json"
print(fence)
print(json.dumps(d, indent=2))
print("\x60" * 3)
PY
  rm -f "$tmp"
  echo "wrote docs/INVENTORY.md" >&2
fi
