---
name: jarvis-sec
description: JARVIS Autonomous Security Ecosystem — 14 AI-powered agents, 48 tools, 9 attack chains for macOS native pentesting
version: 1.0.0
tags: [security, pentesting, hacking, offensive, defensive, osint, forensics, cloud]
trigger: security testing, pentesting, hacking, vulnerability scanning, OSINT, forensics, exploit, credential attack, compliance
---

# JARVIS Security Ecosystem

macOS-native security testing platform with 14 AI-powered agents, 48 registered tools,
and 9 pre-built attack chains. Ollama local models provide the AI brain (zero cloud cost).

## Quick Reference

```bash
# System status
jarvis-sec status

# Single agent operations
jarvis-sec recon <target> --mode active
jarvis-sec scan <target> --type full
jarvis-sec osint <target>
jarvis-sec web <url> --attack sqli
jarvis-sec exploit <target> --vuln sqli --cve CVE-xxxx-xxxxx
jarvis-sec creds <target> --attack brute --service ssh
jarvis-sec ad <dc-ip> --domain corp.local --attack full
jarvis-sec postex <target> --op pivot
jarvis-sec cloud --provider aws --assess audit
jarvis-sec forensics <file> --type file
jarvis-sec posture <url>
jarvis-sec comply <target> --framework nist
jarvis-sec threat <file> --type malware
jarvis-sec endpoint --check full

# Multi-agent missions
jarvis-sec mission <target> --obj "full penetration test"
jarvis-sec mission <target> --chain red_team
jarvis-sec mission <target> --chain web_assessment

# Utilities
jarvis-sec tools      # Show installed/missing tools
jarvis-sec agents     # List all agents
jarvis-sec chains     # List attack chains
jarvis-sec audit      # Verify audit chain integrity
```

## 14 Agents

| Agent | Division | Purpose |
|-------|----------|---------|
| recon | Offensive | DNS, HTTP fingerprint, port scan, tech detection |
| scanner | Offensive | Multi-tool vuln scanning (nmap, nuclei, nikto, whatweb) |
| osint | Offensive | Social media, email, subdomain, IP intelligence |
| web_attack | Offensive | OWASP Top 10: SQLi, XSS, fuzzing, crawling |
| exploit | Offensive | AI-guided exploitation, payload crafting, CVE verification |
| cred_attack | Offensive | Brute force, hash cracking, password spraying |
| ad_attack | Offensive | AD enum, Kerberoast, ADCS, SMB, lateral movement |
| post_exploit | Offensive | C2, persistence, pivoting, data exfil |
| cloud_recon | Offensive | AWS/Azure/GCP audit, IaC scan, privesc |
| forensics | Defensive | File analysis, PCAP, memory forensics, YARA |
| web_posture | Defensive | Security headers, TLS, cookies, CSP |
| compliance | Defensive | CIS, NIST CSF, OWASP, PCI-DSS gap analysis |
| threat_intel | Defensive | IoC analysis, log patterns, malware triage |
| endpoint | Defensive | macOS hardening, baseline drift, process audit |

## 9 Attack Chains

| Chain | Agents |
|-------|--------|
| full_pentest | recon -> scanner -> osint -> web_attack -> exploit -> post_exploit |
| red_team | osint -> recon -> scanner -> exploit -> post_exploit -> cred_attack |
| web_assessment | recon -> web_posture -> scanner -> web_attack |
| network_pentest | recon -> scanner -> cred_attack -> post_exploit |
| ad_attack | recon -> scanner -> ad_attack -> cred_attack -> post_exploit |
| cloud_audit | cloud_recon -> compliance -> scanner |
| osint_investigation | osint -> recon -> threat_intel |
| incident_response | forensics -> threat_intel -> endpoint |
| defensive_audit | web_posture -> endpoint -> compliance -> threat_intel |

## AI Models (Ollama)

| Role | Model | Purpose |
|------|-------|---------|
| Fast | qwen3:8b | Quick tactical decisions, scan analysis |
| Code | code-assistant | Exploit review, payload craft, script analysis |
| Analysis | qwen3.5:cloud | Attack paths, reports, complex reasoning |
| Embed | nomic-embed-text | Vector search over findings/vulndb |

## Tool Installation

When online: `bash ~/jarvis-sec/scripts/install_tools.sh`

Installs 48 tools via Homebrew + pip + Go, plus Z4nzu/hackingtool and SecLists wordlists.

## Project Location

`~/jarvis-sec/` — 24 Python files, 2604 lines
