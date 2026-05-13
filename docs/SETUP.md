# Setup

How to install and use this repository as your Claude Code configuration.

## Prerequisites

- macOS or Linux. Tested on macOS ARM64.
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed.
- `git` 2.40+.
- Python 3.10+ (for `scripts/`).
- Optional but recommended: `gitleaks`, `trivy`, `ruff`, `pre-commit`, `jq`.

## Install

```bash
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
```

### Option A — use as your global `~/.claude/`

Back up any existing config first:

```bash
[ -d ~/.claude ] && mv ~/.claude ~/.claude.backup.$(date +%Y%m%d-%H%M%S)
ln -s "$(pwd)" ~/.claude
```

### Option B — adopt as a per-project config

Copy the files you want into the target project's `.claude/` directory:

```bash
mkdir -p /path/to/project/.claude
cp -R CLAUDE.md core/ skills/ commands/ agents/ hooks/ /path/to/project/.claude/
```

### Option C — fork into a new repo via the starter template

```bash
bash scripts/apply-ai-os-template.sh /path/to/new/project
```

## Configure

1. Copy and edit the environment template:
    ```bash
    cp .env.example .env
    # edit .env locally; never commit it
    ```
2. Run `/onboard` inside Claude Code once to populate `context/` with your own answers. The placeholder files in this repo are public-safe; your answers stay in your local working copy (gitignored when you fork).
3. Review `connections.md` and document only what you intend to wire up.
4. Verify the hook layer works:
    ```bash
    bash scripts/validate.sh
    ```

## Verify it works

```bash
# in any directory
claude
```

You should see the session-start banner and a few SessionStart hook messages. If you see hook errors, see [`docs/TROUBLESHOOTING.md`](TROUBLESHOOTING.md).

## Common next steps

- `/audit` — score your setup across the Four Cs.
- `/onboard` — populate personal context.
- `/level-up` — weekly improvement loop.
- `/audit-deep` — full-stack code/architecture audit on a target repo.

## Updating

```bash
git pull
bash scripts/inventory.sh   # regenerate docs/INVENTORY.md
bash scripts/validate.sh    # confirm internal consistency
```

## Uninstall

```bash
# if you installed via symlink
rm ~/.claude
mv ~/.claude.backup.YYYYMMDD-HHMMSS ~/.claude
```

## Where things live

| Concern | Path |
|---|---|
| Operating contract | [`CLAUDE.md`](../CLAUDE.md) |
| Core rules and identity | [`core/`](../core/) |
| Skills | [`skills/`](../skills/) |
| Slash commands | [`commands/`](../commands/) |
| Agents | [`agents/`](../agents/) (registry: [`agents/REGISTRY.md`](../agents/REGISTRY.md)) |
| Hooks | [`hooks/`](../hooks/) (reference: [`docs/HOOKS.md`](HOOKS.md)) |
| MCP governance | [`docs/MCP_GOVERNANCE.md`](MCP_GOVERNANCE.md) |
| Recipes (parameterized workflows) | [`recipes/`](../recipes/) |
| KB / wiki | [`kb/`](../kb/) |
| Memory layer | [`memory/`](../memory/) |
| Decisions log | [`decisions/`](../decisions/) |
