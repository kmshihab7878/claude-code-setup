#!/usr/bin/env bash
# Recipe Runner — Parses and validates YAML recipes for Claude Code
# Inspired by Goose's Recipe system, adapted for Claude Code's skill architecture
#
# Usage: recipe-runner.sh <recipe.yaml> [--param key=value ...]
# Output: Parsed recipe as JSON for Claude Code consumption

set -euo pipefail

RECIPE_FILE="${1:-}"
shift 2>/dev/null || true

if [ -z "$RECIPE_FILE" ]; then
    echo "Error: No recipe file specified"
    echo "Usage: recipe-runner.sh <recipe.yaml> [--param key=value ...]"
    exit 1
fi

# Resolve recipe path
if [ ! -f "$RECIPE_FILE" ]; then
    # Check in recipes directory
    if [ -f "$HOME/.claude/recipes/$RECIPE_FILE" ]; then
        RECIPE_FILE="$HOME/.claude/recipes/$RECIPE_FILE"
    elif [ -f "$HOME/.claude/recipes/${RECIPE_FILE}.yaml" ]; then
        RECIPE_FILE="$HOME/.claude/recipes/${RECIPE_FILE}.yaml"
    else
        echo "Error: Recipe not found: $RECIPE_FILE"
        echo "Searched: ./, ~/.claude/recipes/"
        exit 1
    fi
fi

# Collect --param arguments into a JSON object
PARAMS="{}"
while [ $# -gt 0 ]; do
    case "$1" in
        --param)
            shift
            KEY="${1%%=*}"
            VALUE="${1#*=}"
            PARAMS=$(echo "$PARAMS" | python3 -c "
import sys, json
params = json.load(sys.stdin)
params['$KEY'] = '$VALUE'
json.dump(params, sys.stdout)
")
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Parse YAML recipe to JSON (uses Python since yq may not be installed)
python3 << 'PYEOF'
import sys, json, re, os

recipe_file = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("RECIPE_FILE", "")

def parse_yaml_simple(path):
    """Minimal YAML parser for recipe files (no PyYAML dependency)."""
    with open(path) as f:
        content = f.read()

    result = {}
    current_key = None
    current_list = None
    current_dict = None
    indent_stack = []

    for line in content.split("\n"):
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue

        indent = len(line) - len(line.lstrip())

        # Key-value pair
        kv_match = re.match(r'^(\w[\w_-]*)\s*:\s*(.*)$', stripped)
        if kv_match:
            key, value = kv_match.group(1), kv_match.group(2).strip()
            if value.startswith('"') and value.endswith('"'):
                value = value[1:-1]
            elif value.startswith("'") and value.endswith("'"):
                value = value[1:-1]
            elif value == "true":
                value = True
            elif value == "false":
                value = False
            elif value == "":
                value = None
            else:
                try:
                    value = int(value)
                except ValueError:
                    try:
                        value = float(value)
                    except ValueError:
                        pass

            if indent == 0:
                result[key] = value if value is not None else []
                current_key = key
                current_list = None if value is not None else result[key]
            continue

        # List item
        if stripped.startswith("- "):
            item = stripped[2:].strip()
            if item.startswith('"') and item.endswith('"'):
                item = item[1:-1]
            if current_key and isinstance(result.get(current_key), list):
                result[current_key].append(item)

    return result

try:
    recipe = parse_yaml_simple(os.environ.get("RECIPE_FILE", ""))
    # Validate required fields
    required = ["version", "title", "prompt"]
    missing = [f for f in required if f not in recipe]
    if missing:
        print(json.dumps({"error": f"Missing required fields: {', '.join(missing)}", "valid": False}))
        sys.exit(1)

    recipe["valid"] = True
    recipe["source_file"] = os.environ.get("RECIPE_FILE", "")
    print(json.dumps(recipe, indent=2))
except Exception as e:
    print(json.dumps({"error": str(e), "valid": False}))
    sys.exit(1)
PYEOF
