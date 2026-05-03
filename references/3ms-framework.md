# Three Ms of AI

> Adapted from AIS-OS by Nate Herk (https://github.com/nateherkai/AIS-OS).
> The Three Ms are how the **operator** thinks about AI work. The Four Cs (`references/four-cs-framework.md`) are how the **system** is structured.

---

## 1. Mindset

How you approach a task before any tool is touched.

### Default Shift
Before starting any task, ask:

> "How could AI do this, or at least 30% of it?"

If the answer is "none of it," you have either misunderstood the task or have not yet built the right capability. Both are useful signals.

### Function Breakdown
Treat every large job as a tree. Automate the **leaves**, not the trunk.

- Trunk: "ship the new pricing page."
- Leaves: write copy variations, generate the price-comparison table, produce 3 mockup options, draft the launch email, set up the GA4 event, draft the changelog entry.

Most leaves are 80%-doable by AI in one pass. The trunk is your judgment.

### Curiosity Rule
Never accept AI output blindly.

- Ask why it produced what it produced.
- Verify against ground truth (the codebase, the data, the customer's actual words).
- When it fails, ask what was missing — context, capability, or constraint.
- **Update the system** when a failure reveals a missing skill, reference, or guardrail. A failure that does not change the system will repeat.

---

## 2. Method

How you turn vague intent into a workable plan.

### Find Constraint
Most workflows have one binding constraint. Identify it before optimising anything else. Examples:
- "I lose 4 hours/week reformatting reports for clients" → constraint is the formatter, not your writing speed.
- "I never get to research because email eats mornings" → constraint is email triage, not research time.

### Eliminate, Automate, Delegate (in that order)
- **Eliminate:** does the task need to exist?
- **Automate:** can a deterministic script or skill do it?
- **Delegate:** can an agent (AI or human) do it under supervision?

If you skip the first two and go straight to "delegate to AI," you build a fancy way of doing something that should not have existed.

### Map Process
Write down the actual steps before automating. Use the format:

```
Trigger: <when does this start?>
Inputs: <what data/state must exist?>
Steps: <numbered, atomic actions>
Outputs: <what is produced?>
Failure modes: <what goes wrong?>
```

Most "AI automation" attempts fail because the underlying manual process was never mapped.

### Pick Autonomy Level
Choose explicitly per task:

| Level | Behavior | When to use |
|-------|----------|-------------|
| Suggest | AI proposes; human decides every action | Sensitive, low-volume, irreversible |
| Confirm | AI prepares; human one-click approves | Repetitive, reversible, judgment-light |
| Auto | AI executes; human reviews periodically | High-volume, low-risk, well-bounded |

Never set a task to **Auto** until it has run successfully at **Confirm** for a week.

### Tie to KPI or Lived Outcome
Every automation has a stated metric — either a business KPI (revenue, retention, churn) or a lived outcome (hours saved, errors avoided, response time). If you cannot state the metric, do not build the automation.

---

## 3. Machine

How you actually build the thing.

### Lego Principle
Build many small composable pieces, not one monolithic agent. A 50-line skill that does one thing reliably beats a 500-line skill that does five things flakily.

### Validation Chain
Every output passes through:

1. Format check (does it match the schema?)
2. Sanity check (do the numbers add up? does the link resolve?)
3. Domain check (does an expert / past-self / golden example agree?)

A capability without a validation chain is a guess generator.

### Bike Method
A POC is to a production system what a bike is to a motorcycle — same shape, no engine, far cheaper to crash. Build the bike first. Ride it manually. Only then add the engine.

### Intern Rule
Treat the AI like a smart intern who is new to your business:
- Give it context (this OS exists for that).
- Give it the goal, the constraints, and the success criteria.
- Review the first three outputs carefully.
- Codify what worked into a skill so the next intern starts from there.

### Kill Switch
Every recurring automation has an off button. Document where it is. Test it once after building. If you cannot stop it in 60 seconds, do not start it.

### Boring Beats Fancy
A `bash` script that runs reliably for a year beats a 4-agent orchestration that needs daily babysitting. Default to the boring deterministic option. Use agents only when judgment is genuinely required.

---

## Productivity warning

Adopting the Three Ms causes a **temporary slowdown** for 1-3 weeks. You are building infrastructure (skills, references, decisions log) that did not exist before. The payoff lands in week 4+ when the same tasks now take 20% of the time.

If you abandon the framework in week 2 because "this is slower than just doing it myself," you will rebuild the same friction every quarter. Treat early friction as setup cost, not failure.

---

## Where these show up in the OS

- **Default Shift** is checked at the start of `/daily-plan`.
- **Function Breakdown** is what `/plan` and `/start-task` produce.
- **Curiosity Rule** drives every `/audit` and the `failure → learning` loop in `docs/RUNBOOK.md`.
- **Map Process** is the input to `skills/skill-architect/`.
- **Validation Chain** is `skills/verification-before-completion/` + `core/governance.md` Stage 6.
- **Kill Switch** is what `~/.claude/state/autonomous.json` makes possible (and what `hooks/persistent-mode.sh` enforces).
