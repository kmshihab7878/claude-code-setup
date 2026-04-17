#!/usr/bin/env bash
# Analyze the telemetry log at ~/.claude/usage.jsonl.
# Prints: top-20 surfaces, zero-invocation surfaces, planner ratio, session counts.
#
# Usage:  scripts/analyze-usage.sh [--since DAYS]  (default: 30)

set -uo pipefail

SINCE_DAYS="${2:-30}"
if [ "${1:-}" = "--since" ]; then SINCE_DAYS="${2:-30}"; fi

LOG="${CLAUDE_USAGE_LOG:-$HOME/.claude/usage.jsonl}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -f "$LOG" ]; then
  echo "No telemetry log at $LOG yet."
  echo "To start collecting, confirm the usage-logger hook is installed (settings.json -> PreToolUse)"
  echo "and that ~/.claude/ is writable. Come back after ≥ 7 days of real usage."
  exit 0
fi

since_epoch=$(python3 -c "import datetime,sys; print(int((datetime.datetime.utcnow() - datetime.timedelta(days=int(sys.argv[1]))).timestamp()))" "$SINCE_DAYS")

python3 - "$LOG" "$since_epoch" "$REPO_ROOT" <<'PY'
import json, sys, os, datetime, collections

log_path, since_epoch, repo_root = sys.argv[1], int(sys.argv[2]), sys.argv[3]
events = []
with open(log_path) as f:
    for line in f:
        line = line.strip()
        if not line: continue
        try:
            e = json.loads(line)
        except Exception:
            continue
        ts = e.get('ts', '')
        try:
            t = datetime.datetime.strptime(ts, '%Y-%m-%dT%H:%M:%SZ').timestamp()
        except Exception:
            continue
        if t < since_epoch: continue
        events.append(e)

if not events:
    print(f"No events in last {(datetime.datetime.utcnow().timestamp()-since_epoch)/86400:.0f} days.")
    sys.exit(0)

print(f"# Usage analysis — last {(datetime.datetime.utcnow().timestamp()-since_epoch)/86400:.0f} days")
print(f"# Total events: {len(events)}")
print()

# ---- surface tally ----
def surface(e):
    tool = e.get('tool', '')
    if tool == 'SlashCommand':
        return ('command', e.get('slash_command') or e.get('command_name') or 'unknown')
    if tool == 'Skill':
        return ('skill', e.get('skill') or 'unknown')
    if tool == 'Agent':
        return ('agent', e.get('subagent_type') or 'unknown')
    return ('tool', tool or 'unknown')

counts = collections.Counter()
for e in events:
    kind, name = surface(e)
    counts[(kind, name)] += 1

# Top 20
print("## Top 20 most-invoked surfaces")
print()
print("| Rank | Kind | Name | Invocations |")
print("|-----:|------|------|------------:|")
for i, ((kind, name), n) in enumerate(counts.most_common(20), 1):
    print(f"| {i} | {kind} | `{name}` | {n} |")
print()

# Session counts
sessions = collections.Counter(e.get('session', '') for e in events)
print(f"## Sessions: {len(sessions)} distinct  ·  median events/session: "
      f"{sorted(sessions.values())[len(sessions)//2] if sessions else 0}")
print()

# Planner ratio
plans = {name: n for (kind, name), n in counts.items()
         if kind == 'command' and name in ('plan', 'ultraplan', 'planUI')}
if plans:
    print("## Planner usage")
    tot = sum(plans.values())
    for name in ('plan', 'ultraplan', 'planUI'):
        c = plans.get(name, 0)
        pct = (100.0 * c / tot) if tot else 0
        print(f"- /{name}: {c} ({pct:.0f}%)")
    print()
else:
    print("## Planner usage: no /plan, /ultraplan, or /planUI invocations in window\n")

# ---- zero-invocation surfaces (cross-reference with inventory) ----
def inventory_names(kind):
    if kind == 'skill':
        return {os.path.basename(os.path.dirname(p)) for p in
                os.popen(f"find {repo_root}/skills -name SKILL.md -type f").read().split() if p}
    if kind == 'command':
        return {os.path.splitext(os.path.basename(p))[0] for p in
                os.popen(f"find {repo_root}/commands -maxdepth 1 -name '*.md' -type f").read().split() if p}
    if kind == 'agent':
        return {os.path.splitext(os.path.basename(p))[0] for p in
                os.popen(f"find {repo_root}/agents -maxdepth 1 -name '*.md' -type f ! -name README.md ! -name REGISTRY.md").read().split() if p}
    return set()

used = {kind: {name for (k, name), _ in counts.items() if k == kind}
        for kind in ('skill', 'command', 'agent')}

print("## Zero-invocation surfaces (candidates for archive)")
print()
for kind in ('skill', 'command', 'agent'):
    inv = inventory_names(kind)
    zero = inv - used[kind]
    print(f"**{kind}s**: {len(zero)} / {len(inv)} never invoked in window")
    # print first 15 as a hint
    for n in sorted(zero)[:15]:
        print(f"  - {n}")
    if len(zero) > 15:
        print(f"  ... and {len(zero) - 15} more")
    print()

PY
