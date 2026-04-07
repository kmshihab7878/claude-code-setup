# Security Audit

Run a comprehensive security audit on the specified scope.

## Instructions

1. Determine scope: Use `$ARGUMENTS` if provided, otherwise audit the entire project
2. Perform OWASP Top 10 analysis:
   - Injection vulnerabilities (SQL, NoSQL, OS command, LDAP)
   - Broken authentication and session management
   - Sensitive data exposure (PII, credentials, tokens)
   - XML external entities
   - Broken access control (IDOR, privilege escalation)
   - Security misconfiguration
   - Cross-site scripting (XSS)
   - Insecure deserialization
   - Components with known vulnerabilities
   - Insufficient logging and monitoring
3. Scan for secrets:
   - Grep for API keys, tokens, passwords in code
   - Check for .env files in version control
   - Identify hardcoded credentials
4. Analyze authentication flows
5. Check dependency versions against known CVEs
6. Rate findings by severity: CRITICAL / HIGH / MEDIUM / LOW
7. Provide specific remediation steps for each finding

Output a structured security report with risk summary and prioritized remediation.
