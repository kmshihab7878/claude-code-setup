# CoreMind Security Ecosystem

Run the CoreMind Security Ecosystem against a target. Routes to the appropriate agent or attack chain.

## Instructions

Parse `$ARGUMENTS` to determine the operation:

### Single Agent Operations
If the user specifies a specific operation, route to that agent:
- `recon <target>` → `coremind-sec recon <target> --mode active`
- `scan <target>` → `coremind-sec scan <target> --type full`
- `osint <target>` → `coremind-sec osint <target>`
- `web <url>` → `coremind-sec web <url> --attack full`
- `exploit <target> <vuln>` → `coremind-sec exploit <target> --vuln <vuln>`
- `creds <target> <service>` → `coremind-sec creds <target> --service <service>`
- `ad <dc-ip> <domain>` → `coremind-sec ad <dc-ip> --domain <domain> --attack full`
- `postex <target>` → `coremind-sec postex <target>`
- `cloud <provider>` → `coremind-sec cloud --provider <provider>`
- `forensics <file>` → `coremind-sec forensics <file>`
- `posture <url>` → `coremind-sec posture <url>`
- `comply <target> <framework>` → `coremind-sec comply <target> --framework <framework>`
- `threat <file>` → `coremind-sec threat <file>`
- `endpoint` → `coremind-sec endpoint --check full`

### Multi-Agent Missions
If the user specifies a mission or complex objective:
- `mission <target>` → `coremind-sec mission <target> --obj "<objective>"`
- `pentest <target>` → `coremind-sec mission <target> --chain full_pentest`
- `redteam <target>` → `coremind-sec mission <target> --chain red_team`

### Utility
- `status` → `coremind-sec status`
- `tools` → `coremind-sec tools`
- `agents` → `coremind-sec agents`
- `install` → `bash ~/coremind-sec/scripts/install_tools.sh`

### Default behavior
If only a target is given with no specific operation, run a full pentest mission:
```bash
coremind-sec mission <target> --obj "full penetration test"
```

## Important
- All operations are logged to the SHA-256 hash-chained audit trail
- AI analysis is powered by local Ollama models (zero cloud cost)
- 48 security tools registered; run `coremind-sec tools` to check what's installed
- If tools are missing, run `bash ~/coremind-sec/scripts/install_tools.sh` when online
