# AIS-OS Reference

_Placeholder. Source repo not cloned in this branch._

## What AIS-OS provides this AI OS

AIS-OS by Nate Herk (https://github.com/nateherkai/AIS-OS) contributes the **personal/business operating layer** — not the execution engine, not the codebase intelligence, not the policy gate. Specifically:

| AIS-OS concept | Where it lives in this repo |
|----------------|------------------------------|
| Three Ms (Mindset / Method / Machine) | `references/3ms-framework.md` |
| Four Cs (Context / Connections / Capabilities / Cadence) | `references/four-cs-framework.md` |
| `/onboard` interview flow | `skills/onboard/SKILL.md` + `aios-intake.md` |
| `/audit` weekly score | `skills/audit/SKILL.md` |
| `/level-up` improvement loop | `skills/level-up/SKILL.md` |
| `context/` folder | `context/` (this repo) |
| `connections.md` | `connections.md` (this repo) |
| `decisions/log.md` | `decisions/log.md` (this repo) |
| `archives/` | `archives/` (this repo) |
| Wiki layer (`raw/`, `wiki/`, `_index.md`, `_log.md`, `_hot.md`) | Existing `kb/raw/` + `kb/wiki/` (renamed in-place: see `docs/WIKI_LAYER.md`) |
| Weekly improvement loop | `skills/weekly-operating-review/SKILL.md` + `docs/CADENCE.md` |
| Skill-building framework | `references/skill-building-framework.md` |
| Tool/domain mapping | `docs/CONNECTIONS_ROADMAP.md` |
| Cadence planning | `docs/CADENCE.md` |

## To clone the reference repo (optional)

Document only. Do not run automatically.

```bash
git clone https://github.com/nateherkai/AIS-OS.git references/external/ais-os/repo
```

After cloning:
1. Add `references/external/ais-os/repo/` to `.gitignore` (already done).
2. Read `references/external/ais-os/repo/README.md` to compare upstream changes against this repo's adapted versions.
3. Do NOT copy AIS-OS files verbatim into the rest of this repo — the integration above is intentional.

## Attribution

The Three Ms, Four Cs, weekly audit/level-up loop, and the personal-OS pattern in this repo are adapted from AIS-OS by Nate Herk. Patterns that were adapted are credited inline in the corresponding reference files.

## Why a reference, not a fork

This repo (`claude-code-setup`) is the canonical constitution. AIS-OS is a framework reference. Copying AIS-OS files in would create two competing policy systems. Keeping AIS-OS as a reference lets the user pull updates without overwriting customisations.
