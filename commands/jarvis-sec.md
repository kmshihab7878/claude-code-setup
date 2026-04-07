# JARVIS Security Ecosystem

Run the JARVIS Security Ecosystem against a target. Routes to the appropriate agent or attack chain.

## Instructions

Parse `$ARGUMENTS` to determine the operation:

### Single Agent Operations
If the user specifies a specific operation, route to that agent:
- `recon <target>` → `jarvis-sec recon <target> --mode active`
- `scan <target>` → `jarvis-sec scan <target> --type full`
- `osint <target>` → `jarvis-sec osint <target>`
- `web <url>` → `jarvis-sec web <url> --attack full`
- `exploit <target> <vuln>` → `jarvis-sec exploit <target> --vuln <vuln>`
- `creds <target> <service>` → `jarvis-sec creds <target> --service <service>`
- `ad <dc-ip> <domain>` → `jarvis-sec ad <dc-ip> --domain <domain> --attack full`
- `postex <target>` → `jarvis-sec postex <target>`
- `cloud <provider>` → `jarvis-sec cloud --provider <provider>`
- `forensics <file>` → `jarvis-sec forensics <file>`
- `posture <url>` → `jarvis-sec posture <url>`
- `comply <target> <framework>` → `jarvis-sec comply <target> --framework <framework>`
- `threat <file>` → `jarvis-sec threat <file>`
- `endpoint` → `jarvis-sec endpoint --check full`

### Multi-Agent Missions
If the user specifies a mission or complex objective:
- `mission <target>` → `jarvis-sec mission <target> --obj "<objective>"`
- `pentest <target>` → `jarvis-sec mission <target> --chain full_pentest`
- `redteam <target>` → `jarvis-sec mission <target> --chain red_team`

### Utility
- `status` → `jarvis-sec status`
- `tools` → `jarvis-sec tools`
- `agents` → `jarvis-sec agents`
- `install` → `bash ~/jarvis-sec/scripts/install_tools.sh`

### Default behavior
If only a target is given with no specific operation, run a full pentest mission:
```bash
jarvis-sec mission <target> --obj "full penetration test"
```

## Important
- All operations are logged to the SHA-256 hash-chained audit trail
- AI analysis is powered by local Ollama models (zero cloud cost)
- 48 security tools registered; run `jarvis-sec tools` to check what's installed
- If tools are missing, run `bash ~/jarvis-sec/scripts/install_tools.sh` when online
