#!/usr/bin/env bash
# Append one JSON line per tool invocation to ~/.claude/usage.jsonl.
# Reads hook JSON from stdin (official Claude Code hook spec).
# Fails silently; never blocks a tool call.
#
# Analysis:  scripts/analyze-usage.sh

set -u
python3 - <<'PY' 2>/dev/null
import sys, json, datetime, os
try:
    d = json.load(sys.stdin)
except Exception:
    d = {}
ti = d.get('tool_input') or {}
rec = {
    'ts': datetime.datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'),
    'event': d.get('hook_event_name', ''),
    'tool': d.get('tool_name', ''),
    'session': (d.get('session_id') or '')[:12],
}
if isinstance(ti, dict):
    # Only fields with stable semantics across Claude Code versions.
    for k in ('command', 'file_path', 'subagent_type', 'skill', 'slash_command', 'command_name'):
        v = ti.get(k)
        if v:
            rec[k] = str(v)[:200]
try:
    log = os.path.expanduser('~/.claude/usage.jsonl')
    with open(log, 'a') as f:
        f.write(json.dumps(rec) + '\n')
except Exception:
    pass
PY
exit 0
