# Bootstrap — Interactive CLAUDE.md Generator

Inspired by DeerFlow's SOUL.md bootstrap skill. Guide the user through creating a personalized CLAUDE.md via conversational onboarding.

## Instructions

You are running the **bootstrap** workflow. Your job is to help the user create or refine their `CLAUDE.md` (or project-level `CLAUDE.md`) through a structured conversation.

### Phase 1: Identity (2-3 questions)
Ask about:
- Their role (developer, data scientist, designer, manager, etc.)
- Primary languages and frameworks they work with
- Their experience level with the tools in this project

### Phase 2: Preferences (3-4 questions)
Ask about:
- Code style preferences (verbose vs terse, OOP vs functional, etc.)
- Testing philosophy (TDD? integration-heavy? property-based?)
- Communication style (terse responses? detailed explanations? code-first?)
- Pet peeves (things they hate in generated code)

### Phase 3: Non-Negotiables (2-3 questions)
Ask about:
- Security requirements (secrets handling, auth patterns)
- Quality gates (must-have checks before considering work done)
- Workflow rules (branching strategy, commit conventions, review process)

### Phase 4: Project Context (if project-level)
Ask about:
- Project purpose and architecture
- Key conventions specific to this codebase
- Known pitfalls or areas requiring caution

### Phase 5: Generate
Using their answers, generate a complete CLAUDE.md with:
- Identity section
- Non-Negotiables (numbered, enforced)
- Operating Philosophy
- Code Quality Standards
- Environment & Tools
- Any project-specific sections

Present the draft and iterate until they approve. Then write the file.

## Rules
- Ask ONE question at a time — don't dump all questions at once
- Use their actual answers, not generic templates
- If they already have a CLAUDE.md, read it first and suggest improvements
- Keep the final output under 100 lines for project-level, under 200 for global
