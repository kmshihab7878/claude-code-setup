# AI OS Intake

> The 7-question interview that populates `context/` and seeds `connections.md`. Run via `/onboard`.

---

## Privacy warning — read before answering

**Do NOT paste:**
- Email addresses, phone numbers, home address
- Customer names or any third-party PII
- API keys, passwords, OAuth tokens
- Banking, payment, or financial account details

If you need to capture sensitive info, use `.env` (gitignored), a separate private notes app, or generic descriptions.

---

## The 7 questions

### 1. Who you are
Who are you, what are you building, and what are your current top goals?

### 2. Projects and responsibilities
What projects, businesses, or responsibilities should this AI OS understand?

### 3. Current tool stack

| Domain | Tool(s) |
|--------|---------|
| Revenue | |
| Customer | |
| Calendar | |
| Comms | |
| Tasks | |
| Meetings | |
| Knowledge | |

### 4. Repeated work
What work do you repeat 3+ times per week that the OS could help with?

### 5. Operating preferences
What decisions, preferences, standards, voice/style rules should the OS remember?

### 6. The 10x question
What would break if your workload increased 10x next month?

### 7. Hard limits
What should the OS never do without explicit approval?

---

## What `/onboard` does

Distills your answers into:
- `context/About Me.md` (PII fields blank unless you typed them)
- `context/About Business.md`
- `context/Priorities.md`
- `context/Voice Sample.md`
- `context/Operating Preferences.md`
- `connections.md` Tier-4 rows (from question 3)
- `decisions/log.md` entry (with automation candidates from question 4)

Ends with: "What should I focus on this week?" — if the OS routes correctly, onboarding worked.
