---
paths:
  - "**/auth/**"
  - "**/security/**"
  - "**/middleware*"
  - "**/*secret*"
  - "**/*credential*"
  - "**/*password*"
  - "**/.env*"
  - "**/jarvis-sec/**"
  - "**/jarvis-security-suite/**"
---

# Security Rules

- Never hardcode secrets, API keys, or credentials — use environment variables
- Never log sensitive data (passwords, tokens, PII)
- Validate and sanitize ALL user input at system boundaries
- Use parameterized queries — never string-concatenate SQL
- JWT: verify signature, check expiry, validate claims
- Password storage: bcrypt/argon2 only — never MD5/SHA for passwords
- CORS: explicit allowlist, never `*` in production
- Rate limit authentication endpoints
- Use HTTPS everywhere — no HTTP fallbacks
- File uploads: validate type, size, and content — never trust client-side validation
