# Security Arsenal

> Security tools inventory mapped to Khaled's environment
> Covers: reconnaissance, scanning, exploitation, forensics, CI/CD security
> Compiled: 2026-03-15

---

## Tool Inventory

### Reconnaissance & OSINT

| Tool | Purpose | Type | Integration |
|------|---------|------|-------------|
| Sherlock | Username enumeration across 400+ sites | CLI (Python) | Bash tool |
| theHarvester | Email, subdomain, name harvesting | CLI (Python) | Bash tool |
| Amass | DNS enumeration, subdomain discovery | CLI (Go) | Bash tool |
| Subfinder | Fast subdomain enumeration | CLI (Go) | Bash tool |
| Shodan CLI | Internet-connected device search | CLI + API | API key |
| Maltego | Visual link analysis | GUI | Manual |
| SpiderFoot | OSINT automation platform | Web UI | Docker MCP |

### Scanning & Enumeration

| Tool | Purpose | Type | Integration |
|------|---------|------|-------------|
| Nmap | Port scanning, service detection | CLI | Bash tool |
| Masscan | High-speed port scanning | CLI | Bash tool |
| Nuclei | Template-based vuln scanning | CLI (Go) | Bash tool |
| Nikto | Web server scanner | CLI (Perl) | Bash tool |
| WPScan | WordPress vulnerability scanner | CLI (Ruby) | Bash tool |
| SQLMap | SQL injection automation | CLI (Python) | Bash tool |
| ffuf | Web fuzzer (dirs, params, vhosts) | CLI (Go) | Bash tool |
| Gobuster | Directory/DNS brute-forcer | CLI (Go) | Bash tool |

### Exploitation Frameworks

| Tool | Purpose | Type | Authorization Required |
|------|---------|------|----------------------|
| Metasploit | Exploitation framework | CLI/GUI | Explicit written scope |
| SET | Social engineering toolkit | CLI | Explicit written scope |
| BeEF | Browser exploitation framework | Web UI | Explicit written scope |
| Responder | LLMNR/NBT-NS/mDNS poisoner | CLI | Explicit written scope |

### Code Analysis

| Tool | Purpose | Integration |
|------|---------|-------------|
| Semgrep | Static analysis (SAST) | CI/CD, Bash tool |
| Bandit | Python security linter | CI/CD, Bash tool |
| TruffleHog | Secret scanning in git history | Pre-commit, CI/CD |
| git-secrets | Pre-commit secret prevention | Git hooks |
| GitGraber | GitHub dork-based secret finder | CLI (Python) |
| Trivy | Container vulnerability scanning | Docker MCP, CI/CD |
| Snyk | Dependency vulnerability scanning | CI/CD |

### Forensics & Incident Response

| Tool | Purpose | Type |
|------|---------|------|
| Volatility 3 | Memory forensics | CLI (Python) |
| Autopsy | Disk forensics | GUI |
| Wireshark | Network packet analysis | GUI |
| YARA | Malware pattern matching | CLI |
| CyberChef | Data decoding/analysis | Web UI |

### Dark Web Intelligence (from DeepDarkCTI)

| Source Type | Tools/Platforms | Use Case |
|-------------|----------------|----------|
| Tor monitoring | OnionScan, Ahmia | Hidden service discovery |
| Paste monitoring | PasteHunter | Credential leak detection |
| Forum monitoring | Flare, Recorded Future | Threat actor tracking |
| Telegram | TGStat, Telethon API | Channel monitoring |

---

## Integration Matrix

### With Khaled's MCP Servers

| MCP Server | Security Integration |
|------------|---------------------|
| `github` | GitGraber-style secret scanning, PR security review |
| `docker` | Trivy container scanning, isolated tool deployment |
| `filesystem` | Log analysis, config auditing |
| `memory` | Store investigation findings as knowledge graph |
| `sequential` | Complex threat model reasoning |

### With Khaled's Skills & Agents

| Skill/Agent | Arsenal Integration |
|-------------|---------------------|
| `security-review` skill | SAST tool integration, OWASP checklist |
| `offensive-security` skill | Methodology framework, tool chains |
| `osint-recon` skill | Reconnaissance workflows |
| `security-auditor` agent | Automated scanning delegation |
| `security-engineer` agent | Compliance and hardening checks |

### With JARVIS Security Stack

| JARVIS Component | Arsenal Integration |
|------------------|---------------------|
| GAOS Input Sanitizer | Test with injection payloads |
| PolicyGate | Verify tier enforcement |
| Capability Tokens | Token forgery testing |
| Hash Chain Audit | Integrity verification |
| Compass Blocklist | Pattern bypass testing |

---

## CI/CD Security Checklist (from awesome-cicd-security)

### Pipeline Security

- [ ] **Pin action versions**: Use SHA hashes, not tags (`actions/checkout@<sha>`)
- [ ] **Least privilege tokens**: Minimize `GITHUB_TOKEN` permissions
- [ ] **No secrets in logs**: Mask sensitive output in CI
- [ ] **Ephemeral credentials**: Use OIDC for cloud auth (no long-lived keys)
- [ ] **Dependency scanning**: Dependabot/Renovate + Snyk/Trivy
- [ ] **SAST in pipeline**: Semgrep/CodeQL on every PR
- [ ] **Container scanning**: Trivy before pushing images
- [ ] **Secret scanning**: TruffleHog/git-secrets in pre-commit
- [ ] **Branch protection**: Require reviews, status checks, signed commits
- [ ] **Artifact signing**: Sign container images and binaries
- [ ] **Supply chain**: Lock files, verify checksums, audit new deps

### GitHub Actions Hardening
```yaml
# Recommended workflow security headers
permissions:
  contents: read  # Minimum required
  pull-requests: write  # Only if needed

# Prevent concurrent runs
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

# Pin actions to SHA
steps:
  - uses: actions/checkout@<full-sha>
```

---

## Reverse Engineering Roadmap (from RE-MA-Roadmap)

### Learning Path
1. **Fundamentals**: Assembly (x86/ARM), C, OS internals
2. **Static Analysis**: Ghidra, IDA Free, radare2
3. **Dynamic Analysis**: GDB, x64dbg, Frida
4. **Malware Analysis**: YARA rules, sandbox analysis, behavioral indicators
5. **Advanced**: Anti-analysis techniques, unpacking, kernel debugging

### Key Resources
- Ghidra (NSA, free): Primary disassembler/decompiler
- YARA: Pattern-based malware classification
- Any.run / Joe Sandbox: Online malware analysis
- VirusTotal: Multi-engine file scanning

---

## Defensive Patterns Derived from Offensive Tools

| Offensive Technique | Defensive Countermeasure | Khaled's Enforcement |
|--------------------|--------------------------|---------------------|
| SQL injection (sqlmap) | Parameterized queries | JARVIS GAOS Layer 1 |
| Secret scanning (GitGraber) | Pre-commit hooks | `.githooks/pre-commit` |
| Port scanning (Nmap) | Firewall rules, minimize surface | Terraform security groups |
| Credential stuffing | Rate limiting, MFA | JARVIS Rule 09 |
| Container escape | Non-root, read-only FS | Docker Dockerfile patterns |
| CI/CD pipeline attack | Pinned actions, OIDC auth | devops-patterns skill |

---

## Cross-References

- **offensive-security** skill: Penetration testing methodology
- **osint-recon** skill: OSINT investigation workflows
- **security-review** skill: Code-level security analysis
- **devops-patterns** skill: CI/CD pipeline security
- **SECURITY_PLAYBOOK.md**: 36 security rules (Rules 01-36)
- **CLAUDE_CODE_ARCHITECTURE.md**: Infrastructure inventory
