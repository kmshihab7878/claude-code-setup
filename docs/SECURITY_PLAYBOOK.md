# Security Playbook

> **Owner**: Repository owner
> **Scope**: Claude Code environment, JARVIS-FRESH, Aster DEX, MCP servers
> **Last Updated**: 2026-03-15
> **Rules**: 36 across 8 categories

---

## Overview

This playbook defines 36 security rules tailored to Khaled's environment. Every rule references a specific file, hook, config, or enforcement mechanism. This is not a generic checklist — it maps to the actual infrastructure.

### Category Summary

| Category | Rules | Severity |
|----------|-------|----------|
| A: Secrets & Credentials | 01-05 | Critical |
| B: Authentication & Sessions | 06-09 | Critical |
| C: API & Access Control | 10-14 | Critical |
| D: Agent Security | 15-20 | Critical |
| E: DeFi & Trading Security | 21-25 | High |
| F: MCP Server Trust | 26-29 | High |
| G: Infrastructure & Deployment | 30-33 | High |
| H: Data & Monitoring | 34-36 | Medium |

---

## Category A: Secrets & Credentials (Critical)

### Rule 01: No Secrets in Source Code

**What**: Never hardcode API keys, tokens, passwords, or secrets in any source file.

**Enforcement**:
- PreToolUse hook blocks writes to `.env`, `.pem`, `.key`, `credentials`, `secret` files
- `~/.claude/settings.json` → `hooks.PreToolUse[0]`
- JARVIS compass blocklist scans for `"changeme"` literals
- Non-Negotiable #2 (Security-first)

**Verification**:
```bash
# Check for hardcoded secrets in a project
grep -rn "password\s*=\s*['\"]" --include="*.py" .
grep -rn "api_key\s*=\s*['\"]" --include="*.py" .
grep -rn "changeme" --include="*.py" .
```

### Rule 02: Encrypted Key Storage

**What**: All API keys and credentials must be stored encrypted, never in plain text.

**Enforcement**:
- Aster DEX keys: Fernet-encrypted in `~/.config/aster-mcp/`
- GitHub: `gh auth` managed PAT (OS keychain)
- JARVIS: All secrets load from environment variables; missing secrets cause `RuntimeError` at startup
- JARVIS CLAUDE.md Section 1.2: "No default secrets may exist in production code"

**Verification**:
```bash
# Verify Aster keys are encrypted
file ~/.config/aster-mcp/*.json 2>/dev/null
aster-mcp list  # Shows accounts without exposing keys

# Verify no plain-text keys in config
grep -rn "AKIA\|sk-\|ghp_\|ghu_" ~/.claude/ --include="*.json" 2>/dev/null
```

### Rule 03: Git Pre-Commit Secret Scanning

**What**: Secrets must be caught before they reach version control.

**Enforcement**:
- JARVIS: `.githooks/pre-commit` runs `compass_check.sh` which scans for forbidden patterns
- `scripts/compass/patterns.blocklist.txt` defines all forbidden patterns
- Global `.gitignore` should cover `.env`, `*.pem`, `*.key`, `credentials.*`

**Verification**:
```bash
# Verify JARVIS git hooks are active
ls -la ~/your-project/.githooks/pre-commit
cat ~/your-project/scripts/compass/patterns.blocklist.txt
```

### Rule 04: Credential Rotation

**What**: Rotate credentials immediately if exposed; rotate proactively on schedule.

**Actions**:
- If any key appears in a commit: rotate immediately, force-push removal, scan history with `git filter-repo`
- Aster keys: `aster-mcp config` to reconfigure with new keys
- GitHub PAT: Regenerate via GitHub Settings → Developer Settings → PATs

### Rule 05: Environment Separation

**What**: Separate credentials by environment (dev/staging/prod). Never use production keys in development.

**Enforcement**:
- JARVIS: `config/policies/` contains environment-specific policy configs
- Aster: Account IDs distinguish environments (`main`, `test`)
- Docker: `.env.example` provided, actual `.env` gitignored

---

## Category B: Authentication & Sessions (Critical)

### Rule 06: JWT with Redis Token Blacklist

**What**: Use short-lived JWTs with server-side revocation capability.

**Enforcement**:
- JARVIS: `src/jarvis/security/jwt_service.py` — JWT creation and validation
- JARVIS: `src/jarvis/security/redis_token_blacklist.py` — Token revocation via Redis
- JARVIS: `src/jarvis/security/token_blacklist.py` — In-memory fallback
- WebSocket auth requires valid JWT (Section 7 of COMPASS)

**Verification**:
```bash
# Verify JWT service exists and uses proper algorithms
grep -n "algorithm" ~/your-project/src/jarvis/security/jwt_service.py
```

### Rule 07: RBAC Enforcement

**What**: Role-Based Access Control on every endpoint. Validate permissions server-side.

**Enforcement**:
- JARVIS: `src/jarvis/security/rbac.py` — Role definitions and permission checks
- Never rely on client-side role checks
- Log all authorization failures

**Verification**:
```bash
# Verify RBAC module exists
ls -la ~/your-project/src/jarvis/security/rbac.py
```

### Rule 08: Session Security

**What**: Secure session handling with proper cookie attributes and timeout.

**Enforcement**:
- JARVIS: `src/jarvis/security/auth_sessions.py` — Session management
- Use HttpOnly, Secure, SameSite=Strict cookies
- Implement session timeout and idle detection

### Rule 09: Rate Limiting

**What**: Rate limit authentication endpoints and API calls to prevent brute force.

**Enforcement**:
- JARVIS: Distributed rate limiting via Redis
- Aster API: Respect 429 responses; back off and inform user
- Implement account lockout after repeated auth failures

---

## Category C: API & Access Control (Critical)

### Rule 10: Input Sanitization at System Boundaries

**What**: Validate and sanitize ALL external input. Fail closed.

**Enforcement**:
- JARVIS GAOS Layer 1: `src/jarvis/gaos/input_sanitizer.py`
  - Max content length enforcement
  - Injection detection (SQL, XSS, template injection)
  - Null byte check
  - Encoding validation
- Use allowlists over denylists

**Verification**:
```bash
# Verify input sanitizer exists
ls -la ~/your-project/src/jarvis/gaos/input_sanitizer.py
```

### Rule 11: PolicyGate Tiered Authorization

**What**: Every action passes through a 4-tier policy gate: ALLOW / REVIEW / ESCALATE / BLOCK.

**Enforcement**:
- JARVIS: `src/jarvis/core/policy_gate.py` — 7 constraints enforced at every gate
- PolicyGate constraints may NOT be bypassed without ESCALATE-level approval
- JARVIS CLAUDE.md Section 1.2: "Governance Cannot Be Weakened"

**Verification**:
```bash
# Verify PolicyGate implementation
grep -n "ALLOW\|REVIEW\|ESCALATE\|BLOCK" ~/your-project/src/jarvis/core/policy_gate.py | head -20
```

### Rule 12: Injection Prevention

**What**: Prevent SQL injection, XSS, command injection, path traversal, SSRF, and template injection.

**Enforcement**:
- SQL: Parameterized queries via SQLAlchemy ORM (never string concatenation)
- XSS: Framework auto-escaping
- Command injection: Avoid `os.system()`, `exec()`, `eval()`; use subprocess with argument lists
- Path traversal: Validate and canonicalize; reject `..` sequences
- SSRF: Allowlist outbound URLs; block internal ranges
- JARVIS GAOS input sanitizer detects injection patterns at runtime

### Rule 13: API Schema Protection

**What**: Don't expose internal schemas, stack traces, or debug info in API responses.

**Enforcement**:
- FastAPI: Disable OpenAPI docs in production
- Never return raw exception messages to clients
- Use structured error responses with error codes, not internal details

### Rule 14: CORS and CSRF

**What**: Configure CORS with specific origins. Implement CSRF tokens for state-changing requests.

**Enforcement**:
- Never use `CORS: *` in production
- JARVIS: FastAPI CORS middleware with specific allowed origins
- CSRF tokens on all state-changing endpoints

---

## Category D: Agent Security (Critical)

### Rule 15: SEC-001 Coordinator Guard

**What**: ALL agent execution must flow through `AgentCoordinator`. Direct `agent.run()` calls are forbidden.

**Enforcement**:
- JARVIS: `contextvars` guard raises `CoordinatorSecurityError` at runtime for direct calls
- Compass blocklist scans for direct `agent.run()` calls outside coordinator
- Any PR failing `compass_check.sh` is rejected

**Verification**:
```bash
# Scan for direct agent.run() calls
grep -rn "agent\.run(" ~/your-project/src/ --include="*.py" | grep -v "coordinator"
# Run compass check
bash ~/your-project/scripts/compass/compass_check.sh
```

### Rule 16: Immutable Delegation Contracts

**What**: Agents receive immutable `DelegationContract` — they cannot modify goals, risk tiers, or their own authority.

**Enforcement**:
- JARVIS: `src/jarvis/core/contracts/` — Frozen dataclasses
- Contracts: `Intent`, `GoalRecord`, `ExecutionPlan`, `PlanStep`, `DelegationContract`, `ExecutionResult`, `DecisionRecord`, `AuditEvent`, `SideEffect`, `CapabilityToken`
- Zero competing schema variants allowed (canonical schemas only)

### Rule 17: GAOS Capability Tokens

**What**: All side-effects route through the GAOS layer with revocable capability tokens.

**Enforcement**:
- JARVIS: `src/jarvis/gaos/capability_token.py` — Token issuance
- JARVIS: `src/jarvis/gaos/redis_capability_token.py` — Redis-backed tokens
- Flow: `gaos.authorize_execution()` → capability token → `gaos.execute_with_token()`
- Tokens are revocable mid-execution

**Verification**:
```bash
ls -la ~/your-project/src/jarvis/gaos/capability_token.py
ls -la ~/your-project/src/jarvis/gaos/redis_capability_token.py
```

### Rule 18: 5-Layer Safety Stack

**What**: Every agent action passes through 5 safety layers.

**Enforcement** (JARVIS GAOS):

| Layer | Module | Protection |
|-------|--------|------------|
| 1 | `gaos/input_sanitizer.py` | Content length, injection detection, null bytes, encoding |
| 2 | `core/policy_gate.py` | 7 constraints, ALLOW/REVIEW/ESCALATE/BLOCK tiers |
| 3 | `gaos/sandbox.py` | `asyncio.wait_for()` timeouts, capability-gated access, ResourcePool quotas |
| 4 | `gaos/output_validator.py` | PII detection, secret leak detection, length limits, redaction |
| 5 | `gaos/rollback.py` | Side-effect recording, compensation transactions, `abort_goal()` |

### Rule 19: Compass Blocklist

**What**: Forbidden patterns are automatically detected in all code changes.

**Enforcement**:
- `scripts/compass/patterns.blocklist.txt` defines forbidden patterns:
  - `BYPASS_POLICY`, `SKIP_AUDIT`, `DISABLE_AUTH`, `OVERRIDE_SAFETY`
  - Direct `agent.run()` calls outside coordinator
  - Hardcoded secrets or `"changeme"` literals
  - Schema drift (competing contract definitions)
- Pre-commit and pre-push hooks run `compass_check.sh` automatically

**Verification**:
```bash
cat ~/your-project/scripts/compass/patterns.blocklist.txt
```

### Rule 20: Tamper-Evident Audit Trail

**What**: SHA-256 hash chain on all audit entries. Chain integrity is verifiable.

**Enforcement**:
- JARVIS: `src/jarvis/security/hash_chain.py` — SHA-256 chained audit log
- JARVIS: `src/jarvis/security/audit_logger.py` — Audit event persistence
- `verify_chain()` validates integrity; failures trigger incidents
- Every intent, goal, plan, task, and outcome shares a single `trace_id`

**Verification**:
```bash
ls -la ~/your-project/src/jarvis/security/hash_chain.py
ls -la ~/your-project/src/jarvis/security/audit_logger.py
```

---

## Category E: DeFi & Trading Security (High)

### Rule 21: User Confirmation Gate

**What**: ALWAYS confirm with the user before placing ANY trading order. No auto-execution.

**Enforcement**:
- Aster trading skill: "User confirmation required" (Rule 1 in SKILL.md)
- Display full order details: symbol, side, type, quantity, price, leverage
- Show USD equivalent, liquidation price, margin usage
- Non-Negotiable #9 (Approval first)

### Rule 22: Leverage Risk Warnings

**What**: Tiered warnings based on leverage level.

**Enforcement** (Aster trading skill):

| Leverage | Action |
|----------|--------|
| > 10x | Note elevated risk |
| > 20x | Explicit warning about liquidation |
| > 50x | Strongly advise against |
| > 100x | Refuse unless explicit understanding confirmed |

Aster supports up to 1,001x leverage — extreme caution required.

### Rule 23: API Key Masking

**What**: Never log, display, or output full API keys or secrets for trading accounts.

**Enforcement**:
- Aster MCP: Keys stored Fernet-encrypted in `~/.config/aster-mcp/`
- `aster-mcp list` shows accounts without exposing keys
- Never commit credentials to git
- Never store API keys in plain text files

**Verification**:
```bash
# Verify keys are not in plain text
aster-mcp list
# Check no keys leaked in audit log
grep -i "api.key\|secret" ~/.claude/audit.log | head -5
```

### Rule 24: API Rate Limit Respect

**What**: Respect Aster API rate limits. Back off on 429 responses.

**Enforcement**:
- Aster trading skill: "Respect Aster API rate limits" (Rule 5)
- On 429: exponential backoff, inform user
- Never retry aggressively

### Rule 25: Spot/Futures Separation

**What**: Maintain clear separation between spot and futures operations.

**Enforcement**:
- Aster MCP: Separate tool sets for spot (`*_spot_*`) and futures
- Separate API endpoints: `fapi.asterdex.com` (futures), `sapi.asterdex.com` (spot)
- Transfer tools (`transfer_funds`, `transfer_spot_futures`) require explicit direction
- Always confirm transfer direction with user

---

## Category F: MCP Server Trust (High)

### Rule 26: Localhost Isolation

**What**: MCP servers should bind to localhost only. No external network exposure.

**Enforcement**:
- Penpot MCP: Binds to `localhost:4401` (HTTP), `localhost:4402` (WS), `localhost:4400` (plugin)
- All stdio-based MCP servers (memory, filesystem, sequential, github, context7, docker, aster) run as child processes — no network binding

### Rule 27: Package Verification

**What**: Verify MCP server packages before installation. Pin versions.

**Actions**:
- Verify npm packages: check publisher, download counts, last update
- Pin versions in package.json (no `latest` tags)
- For Python MCP servers: use pinned requirements in `~/.venv`
- Review changelogs before updating

### Rule 28: Transport Security

**What**: Use secure transports for MCP communication. Validate TLS for HTTP-based servers.

**Enforcement**:
- stdio transport: Inherently local (no network)
- HTTP transport (penpot): Localhost only; production would require TLS
- Never disable SSL verification in production

### Rule 29: Filesystem Scoping

**What**: Filesystem MCP server must be scoped to allowed directories only.

**Enforcement**:
- `filesystem` MCP server configured with explicit allowed directories
- Never grant root `/` access
- Verify scoping via `list_allowed_directories` tool

**Verification**:
```bash
# Check filesystem MCP allowed dirs (in MCP config)
grep -A5 "filesystem" ~/.claude.json 2>/dev/null
```

---

## Category G: Infrastructure & Deployment (High)

### Rule 30: Container Security

**What**: Docker containers run non-root with minimal base images.

**Enforcement**:
- JARVIS: `docker/` directory contains Dockerfiles
- Use alpine or distroless base images
- Run as non-root user (`USER nonroot`)
- Pin image versions with digest hashes
- Never store secrets in Docker images or layers
- Multi-stage builds to exclude build tools

**Verification**:
```bash
# Check Dockerfiles for non-root user
grep -rn "USER" ~/your-project/docker/ --include="Dockerfile*"
```

### Rule 31: Terraform State Security

**What**: Terraform state must be encrypted and stored in a secure backend.

**Enforcement**:
- JARVIS: `terraform/` directory contains infrastructure code
- Use remote state backend (S3 + DynamoDB lock)
- Enable state encryption at rest
- Never commit `.tfstate` files to git

**Verification**:
```bash
# Verify no state files in git
git -C ~/your-project ls-files | grep -i "tfstate"
```

### Rule 32: Test/Production Separation

**What**: Clear separation between test and production environments.

**Enforcement**:
- JARVIS: `config/phase_gates.yml` defines environment gates
- Separate database credentials per environment
- Separate API endpoints per environment
- Feature flags for gradual rollout

### Rule 33: Health Check Safety

**What**: Health check endpoints must not expose internal state or secrets.

**Enforcement**:
- Return only status codes and minimal metadata
- Never include database connection strings, API keys, or internal IPs
- JARVIS: `tests/test_health.py` validates health endpoint behavior

---

## Category H: Data & Monitoring (Medium)

### Rule 34: PostToolUse Audit Log

**What**: All bash commands executed by Claude Code are logged with timestamps.

**Enforcement**:
- `~/.claude/settings.json` → `hooks.PostToolUse[0]`
- Logs to `~/.claude/audit.log` (currently ~4500 entries)
- Format: `[YYYY-MM-DD HH:MM:SS] Bash: <first 200 chars>`
- Review periodically for anomalous commands

**Verification**:
```bash
# Check recent audit entries
tail -20 ~/.claude/audit.log
# Count total entries
wc -l ~/.claude/audit.log
```

### Rule 35: PII Detection in Agent Output

**What**: Agent outputs must be scanned for PII and secrets before delivery.

**Enforcement**:
- JARVIS GAOS Layer 4: `src/jarvis/gaos/output_validator.py`
  - PII pattern detection (SSN, credit card, email patterns)
  - Secret leak detection (API key patterns)
  - Length limits
  - Automatic redaction

**Verification**:
```bash
ls -la ~/your-project/src/jarvis/gaos/output_validator.py
```

### Rule 36: Database Connection Security

**What**: Secure database connections with pooling, timeouts, and SSL.

**Enforcement**:
- JARVIS: SQLAlchemy async with asyncpg
- Connection pooling with proper limits
- Statement timeouts to prevent long-running queries
- SSL mode for production database connections
- JARVIS: `src/jarvis/db/` contains database layer

---

## Appendix A: Security Infrastructure Inventory

### Claude Code Layer

| Component | File | Purpose |
|-----------|------|---------|
| PreToolUse Hook | `~/.claude/settings.json` | Block writes to sensitive files |
| PostToolUse Hook | `~/.claude/settings.json` | Bash command audit trail |
| Audit Log | `~/.claude/audit.log` | Timestamped command history |
| Security Review Skill | `~/.claude/skills/security-review/SKILL.md` | OWASP Top 10 checklist |
| Aster Trading Skill | `~/.claude/skills/aster-trading/SKILL.md` | Trading risk rules |
| Security Auditor Agent | `~/.claude/agents/security-auditor.md` | Vulnerability scanning |
| Security Engineer Agent | `~/.claude/agents/security-engineer.md` | Compliance checks |

### JARVIS GAOS Layer

| Component | File | Purpose |
|-----------|------|---------|
| Input Sanitizer | `src/jarvis/gaos/input_sanitizer.py` | Injection detection, content validation |
| Policy Gate | `src/jarvis/core/policy_gate.py` | 4-tier authorization |
| Execution Sandbox | `src/jarvis/gaos/sandbox.py` | Timeouts, resource quotas |
| Output Validator | `src/jarvis/gaos/output_validator.py` | PII/secret detection, redaction |
| Rollback Engine | `src/jarvis/gaos/rollback.py` | Compensation transactions |
| Capability Tokens | `src/jarvis/gaos/capability_token.py` | Revocable execution grants |
| Redis Tokens | `src/jarvis/gaos/redis_capability_token.py` | Distributed token management |
| Redis Quotas | `src/jarvis/gaos/redis_quota.py` | Resource pool enforcement |

### JARVIS Security Layer

| Component | File | Purpose |
|-----------|------|---------|
| JWT Service | `src/jarvis/security/jwt_service.py` | Token creation/validation |
| RBAC | `src/jarvis/security/rbac.py` | Role-based access control |
| Hash Chain | `src/jarvis/security/hash_chain.py` | Tamper-evident audit |
| Audit Logger | `src/jarvis/security/audit_logger.py` | Event persistence |
| Token Blacklist | `src/jarvis/security/redis_token_blacklist.py` | JWT revocation |
| Auth Sessions | `src/jarvis/security/auth_sessions.py` | Session management |
| API Key Auth | `src/jarvis/security/api_key_auth.py` | API key validation |

### Governance Scripts

| Script | Path | Purpose |
|--------|------|---------|
| Compass Check | `scripts/compass/compass_check.sh` | Forbidden pattern scanning |
| Blocklist | `scripts/compass/patterns.blocklist.txt` | Pattern definitions |
| Pre-commit Hook | `.githooks/pre-commit` | Automated compass check |
| Pre-push Hook | `.githooks/pre-push` | Automated compass check |
| Benchmark Runner | `scripts/run_benchmarks.py` | Compliance scoring |
| Prompt Verifier | `scripts/verify_sec001_prompt.py` | SEC-001 validation |

---

## Appendix B: Security Verification Commands

Run these to verify security posture:

```bash
# --- Claude Code Layer ---

# 1. Verify PreToolUse hook is active
grep -A5 "PreToolUse" ~/.claude/settings.json

# 2. Verify PostToolUse hook is active
grep -A5 "PostToolUse" ~/.claude/settings.json

# 3. Check audit log health
wc -l ~/.claude/audit.log
tail -5 ~/.claude/audit.log

# 4. Scan for secrets in Claude config
grep -rn "AKIA\|sk-\|ghp_\|password" ~/.claude/ --include="*.json" 2>/dev/null

# --- Aster DEX Layer ---

# 5. Verify Aster accounts (no keys shown)
aster-mcp list

# 6. Test Aster connectivity
aster-mcp test main

# --- JARVIS Layer ---

# 7. Run compass check
cd ~/your-project && bash scripts/compass/compass_check.sh

# 8. Verify git hooks installed
ls -la ~/your-project/.githooks/pre-commit
ls -la ~/your-project/.githooks/pre-push

# 9. Check for direct agent.run() calls
grep -rn "agent\.run(" ~/your-project/src/ --include="*.py" | grep -v "coordinator" | grep -v "test"

# 10. Verify GAOS modules present
ls ~/your-project/src/jarvis/gaos/*.py

# 11. Verify security modules present
ls ~/your-project/src/jarvis/security/*.py

# 12. Check for hardcoded secrets
grep -rn "changeme\|password\s*=\s*['\"]" ~/your-project/src/ --include="*.py"

# --- Container Layer ---

# 13. Check Dockerfiles for non-root
grep -rn "USER" ~/your-project/docker/ --include="Dockerfile*" 2>/dev/null

# 14. Check no .tfstate in git
git -C ~/your-project ls-files | grep -i "tfstate"

# --- MCP Layer ---

# 15. Verify filesystem MCP scoping
grep -A10 "filesystem" ~/.claude.json 2>/dev/null
```

### Quick Security Score

Run all checks and count passes:

```bash
PASS=0; FAIL=0
# Add each check as a function and count results
# This is a template — customize per audit cycle
echo "Security checks: $PASS passed, $FAIL failed"
```

---

## Appendix C: Tool-Specific Security Rules

### Offensive Security Tools

| Rule | Tool | Requirement |
|------|------|-------------|
| C-01 | Any exploit tool | Written authorization with scope document required |
| C-02 | Nmap/Masscan | Only scan authorized IP ranges |
| C-03 | sqlmap | Never auto-exploit; review findings manually first |
| C-04 | Metasploit | Isolated lab environment or authorized engagement only |
| C-05 | SET | Phishing simulations require explicit management approval |
| C-06 | Sherlock/OSINT | Only public information; never access private accounts |

### Secret Scanning Tools

| Rule | Tool | Requirement |
|------|------|-------------|
| C-07 | GitGraber | Only scan own organization's repos |
| C-08 | TruffleHog | Run before every push; integrate with pre-commit hook |
| C-09 | git-secrets | Install in all project repositories |
| C-10 | Trivy | Scan all Docker images before push to registry |

### CI/CD Security

| Rule | Tool/Practice | Requirement |
|------|--------------|-------------|
| C-11 | GitHub Actions | Pin to SHA, never use `@latest` or `@v*` tags |
| C-12 | OIDC Auth | Use OIDC for cloud provider auth (no long-lived keys) |
| C-13 | Action Permissions | Set minimum `permissions` block; never `write-all` |
| C-14 | Third-party Actions | Audit source code and publisher before use |
| C-15 | Container Images | Sign with cosign; pin by digest |

### Data & Privacy

| Rule | Tool | Requirement |
|------|------|-------------|
| C-16 | Neosync | Use for all dev/test databases; never use prod data in dev |
| C-17 | Label Studio | No PII in training datasets without anonymization |
| C-18 | Firecrawl | Respect robots.txt; comply with browser-automation-safety skill |

### Cross-References

- **offensive-security** skill: Pen testing methodology
- **osint-recon** skill: OSINT investigation workflows
- **security-review** skill: Code-level security + CI/CD rules
- **SECURITY_ARSENAL.md**: Complete tool inventory
