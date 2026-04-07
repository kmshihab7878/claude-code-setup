#!/bin/bash
# Keyword Detector — Auto-triggers skills from natural language
# Inspired by oh-my-claudecode's keyword-detector UserPromptSubmit pattern.
#
# Scans user prompt for trigger words and injects skill invocation instructions.
# Runs on UserPromptSubmit hook.
#
# Exit 0 = always allow (just adds context)

# Read prompt from stdin (Claude Code pipes user input)
PROMPT=$(cat)

# Normalize for matching
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')

# ── Cancel detection (highest priority) ──
if echo "$PROMPT_LOWER" | grep -qE '\b(cancel|stop mode|abort mode|exit mode)\b'; then
  # Deactivate any persistent mode
  STATE_DIR="$HOME/.claude/state"
  for f in "$STATE_DIR"/*.json; do
    [ -f "$f" ] || continue
    python3 -c "
import json
with open('$f') as fh:
    d = json.load(fh)
if d.get('active', False):
    d['active'] = False
    d['deactivated_reason'] = 'user cancelled'
    with open('$f', 'w') as fh:
        json.dump(d, fh, indent=2)
" 2>/dev/null
  done
  echo "All persistent modes cancelled."
  exit 0
fi

# ── Skill keyword matching (priority order) ──
MATCHED_SKILL=""
SKILL_CONTEXT=""

# Autonomous mode activation
if echo "$PROMPT_LOWER" | grep -qE '\b(autonomous|autopilot|auto.?mode|keep going|dont stop|don.?t stop)\b'; then
  MATCHED_SKILL="autonomous-mode"
  SKILL_CONTEXT="Autonomous mode requested. Activate persistent execution:
1. Create state file: ~/.claude/state/autonomous.json with {\"active\": true, \"task\": \"<the task>\", \"iteration\": 0, \"max_iterations\": 20, \"created_at\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}
2. Execute the task without stopping until complete or max iterations reached.
3. The Stop hook will prevent premature stopping while mode is active."
fi

# Security review
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(security review|security audit|vuln scan|pentest|penetration test)\b'; then
  MATCHED_SKILL="security-review"
  SKILL_CONTEXT="Security review requested. Apply the /security-review skill. Check OWASP top 10, secrets scanning, auth patterns."
fi

# TDD / test-driven
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(tdd|test.?driven|red.?green|write tests? first)\b'; then
  MATCHED_SKILL="test-driven-development"
  SKILL_CONTEXT="TDD mode requested. Apply /test-driven-development skill. RED → GREEN → REFACTOR cycle."
fi

# Code review
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(code review|review (this|my|the) code|review pr)\b'; then
  MATCHED_SKILL="code-review"
  SKILL_CONTEXT="Code review requested. Apply /review skill. Check correctness, style, performance, security."
fi

# Deep research
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(deep research|research this|investigate thoroughly|deep dive)\b'; then
  MATCHED_SKILL="deep-research"
  SKILL_CONTEXT="Deep research requested. Use deep-research agent with tavily/brave-search MCP servers."
fi

# Architecture / design
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(architect|system design|design system|high.?level design)\b'; then
  MATCHED_SKILL="architecture"
  SKILL_CONTEXT="Architecture work detected. Use system-architect agent (L1). Apply /spec and /plan skills."
fi

# Performance
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(optimize|performance|slow|bottleneck|profil)\b'; then
  MATCHED_SKILL="performance"
  SKILL_CONTEXT="Performance work detected. Use performance-engineer agent (L2). Profile before optimizing."
fi

# Deploy / infrastructure
if [ -z "$MATCHED_SKILL" ] && echo "$PROMPT_LOWER" | grep -qE '\b(deploy|infrastructure|terraform|kubernetes|k8s|docker)\b'; then
  MATCHED_SKILL="infrastructure"
  SKILL_CONTEXT="Infrastructure work detected. Use devops-architect agent (L2). Risk tier T2 — confirm before applying."
fi

# ── Output matched skill context ──
if [ -n "$MATCHED_SKILL" ]; then
  echo "[KEYWORD DETECTED: $MATCHED_SKILL]"
  echo ""
  echo "$SKILL_CONTEXT"
fi

exit 0
