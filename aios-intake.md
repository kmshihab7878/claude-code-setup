# AI OS Intake

> The 7-question interview that populates `context/` and seeds `connections.md`. Run via `/onboard`.

---

## Privacy warning — read before answering

**Do NOT paste any of the following into your answers:**
- Email addresses, phone numbers, home address
- Customer names, account IDs, or any third-party PII
- API keys, passwords, OAuth tokens, secrets of any kind
- Internal-only strategic information you would not paste in a public PR
- Banking, payment, or financial account details

The `/onboard` skill writes your answers into `context/*.md` files inside this repo. If this repo is or will become public (or shared), every word you write ends up there.

If you need to capture sensitive info, use:
- `.env` (gitignored) for credentials
- A separate, private notes app for true secrets
- Generic descriptions in onboarding ("I run a SaaS for small clinics") instead of specifics ("Acme Health Inc, ARR $X, customer Y")

---

## The 7 questions

Answer in paragraphs — not bullet points. Detail and context matter more than brevity here. The OS will distill structure from your prose.

### 1. Who you are

Who are you, what are you building, and what are your current top goals?

> _(Your turn)_

### 2. Projects and responsibilities

What projects, businesses, or responsibilities should this AI OS understand? For each, give the one-sentence elevator pitch.

> _(Your turn)_

### 3. Current tool stack

What tools do you actually use across the seven domains?

| Domain | Tool(s) |
|--------|---------|
| Revenue | _(e.g. Stripe, manual invoicing, none yet)_ |
| Customer | _(e.g. CRM name, spreadsheet, "I just remember them")_ |
| Calendar | _(e.g. Google Calendar, Cal.com, paper)_ |
| Comms | _(e.g. Gmail, Superhuman, Slack, Telegram)_ |
| Tasks | _(e.g. Linear, Notion, Things, sticky notes)_ |
| Meetings | _(e.g. Granola, Otter, Fireflies, no transcription)_ |
| Knowledge | _(e.g. Notion, Obsidian, "in my head")_ |

> _(Your turn — fill the table)_

### 4. Repeated work

What work do you repeat 3+ times per week that the OS could help with?

> _(Your turn — list 3-7 examples with context: who triggers it, what's the input, what's the output)_

### 5. Operating preferences

What decisions, preferences, standards, voice/style rules, or working patterns should the OS remember?

> _(Your turn — examples: "always use British English in customer-facing copy," "never send anything before 9am client-time," "I prefer short Slack replies, long docs," "ship behind feature flags by default")_

### 6. The 10x question

What would break if your workload, customer count, or content cadence increased 10x next month? Be specific — what would you stop doing first, and which workflow would collapse?

> _(Your turn — this surfaces the bottleneck the OS should attack first)_

### 7. Hard limits

What should the OS never do without explicit approval, even if it seems helpful?

> _(Your turn — examples: "never send email," "never push to main," "never accept new MCP servers," "never modify settings.json", "never spend more than $10 on a single API call")_

---

## What `/onboard` does with your answers

| Answer to question | Lands in |
|--------------------|----------|
| 1. Who you are | `context/About Me.md` (with hard PII guard — see skill) |
| 2. Projects | `context/About Business.md` |
| 3. Tool stack | `connections.md` (Tier-4 "manual / planned" rows) + cross-check against `claude mcp list` |
| 4. Repeated work | `decisions/log.md` (entry with `automation candidates: [...]`) — feeds `/level-up` |
| 5. Operating preferences | `context/Operating Preferences.md` + `context/Voice Sample.md` (if you provided text samples) |
| 6. 10x question | `context/Priorities.md` (constraint identification) + flagged for `/level-up` |
| 7. Hard limits | `context/Operating Preferences.md § What the OS should never do` (read at every session start) |

After saving, `/onboard` ends with a validation question: "What should I focus on this week?" If you can answer it and the OS routes appropriately, onboarding worked.

---

## When to re-run

- Major role change (new job, new venture, retired venture)
- Tool stack shift (added/dropped a major tool)
- Quarterly refresh (priorities decay fast)
- After a stretch where the OS feels "off" — usually means context drifted

You can also edit `context/*.md` directly without re-running the full intake. Treat them as living documents.

---

## What `/onboard` will NOT do

- **Will not** auto-fill your name, email, GitHub handle, or any identity from the session environment. You must type these explicitly during the interview, and even then, the skill will warn you about the privacy implications of putting real PII in a repo.
- **Will not** write to any file outside `context/`, `connections.md`, or `decisions/log.md`.
- **Will not** install MCP servers, plugins, or modify `settings.json` based on your answers (it will *suggest* in `decisions/log.md`).
- **Will not** make outbound network calls based on your answers.
